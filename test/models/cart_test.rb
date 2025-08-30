require "test_helper"
require "minitest/mock"

class CartTest < ActiveSupport::TestCase
  test "#total_price calls line_item.total_price" do
    line_item = Minitest::Mock.new
    line_item.expect(:total_price, 1)

    cart = Cart.new
    cart.stub :line_items, [ line_item ] do
      cart.total_price
    end

    assert_mock line_item
  end

  test "#total_items returns sum of line item quantity" do
    assert carts(:one).total_items == line_items(:one).quantity
  end
end
