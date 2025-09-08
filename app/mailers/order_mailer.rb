class OrderMailer < ApplicationMailer
  default from: "Tim Taylor <orders@pco.depot>"

  def received(order)
    @order = order

    mail to: order.email, subject: "Gee willikers! Thanks for your order, #{order.name}!"
  end

  def shipped(order)
    @order = order

    mail to: order.email, subject: "Gitty up! Your order is on its way!"
  end
end
