require "test_helper"

class LineItemTest < ActiveSupport::TestCase
  test "#total_price returns product price multiplied by quantity" do
    manual_total = line_items(:one).product.price * line_items(:one).quantity
    assert line_items(:one).total_price == manual_total
  end
end
