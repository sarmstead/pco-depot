class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy

  enum :pay_type, [ :check, :credit_card, :purchase_order ], validate: true

  validates :name, :address, :email, presence: true

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def charge!(params)
    payment_details = {}
    payment_method = nil

    case pay_type
    when "check"
      payment_method = :check
      payment_details[:routing] = params[:routing_number]
      payment_details[:account] = params[:account_number]
    when "credit_card"
      payment_method = :credit_card
      month, year = params[:expiration_date].split(//)
      payment_details[:cc_num] = params[:credit_card_number]
      payment_details[:expiration_month] = month
      payment_details[:expiration_year] = year
    when "purchase_order"
      payment_method = :po
      payment_details[:po_num] = params[:po_number]
    end

    payment_result = Pago.make_payment(
      order_id: id,
      payment_method: payment_method,
      payment_details: payment_details
    )

    if payment_result.succeeded?
      OrderMailer.received(self).deliver_later
    else
      raise payment_result.error
    end
  end
end
