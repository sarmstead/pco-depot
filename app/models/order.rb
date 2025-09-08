class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy

  enum :pay_type, [ :check, :credit_card, :purchase_order ], validate: true

  validates :name, :address, :email, presence: true
end
