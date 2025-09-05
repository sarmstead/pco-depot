class Order < ApplicationRecord
  enum :pay_type, [ :check, :credit_card, :purchase_order ]
end
