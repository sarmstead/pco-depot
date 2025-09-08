class ChargeOrderJob < ApplicationJob
  queue_as :default

  def perform(order, params)
    order.charge!(params)
  end
end
