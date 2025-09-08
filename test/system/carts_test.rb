require "application_system_test_case"

class CartsTest < ApplicationSystemTestCase
  setup do
    @cart = carts(:one)
  end

  test "visiting the index" do
    visit carts_url
    assert_selector "h1", text: "Carts"
  end

  test "should create cart" do
    visit store_index_url
    click_on "Add to Cart", match: :first
    click_on "Cart"

    assert_text "Cart"
    assert_text "Order Summary"
  end

  test "should destroy Cart" do
    visit cart_url(@cart)
    click_on "Empty Cart"

    assert_current_path store_index_url
  end
end
