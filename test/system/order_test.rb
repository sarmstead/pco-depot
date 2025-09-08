require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  test "placing an order" do
    visit store_index_url
    click_on "Add to Cart", match: :first
    click_on "Checkout"
    assert_current_path new_order_url
    assert_text "Checkout"
    assert_text "Cart"
    assert_text "Order Summary"
    fill_in "Name", with: "Jill Taylor"
    fill_in "Address", with: "123 Easy Street, Royal Oak, Michigan, 48067"
    fill_in "Email", with: "jtaylor@example.net"

    select "Check", from: "Pay type"
    assert has_field? "Routing number"
    assert has_field? "Account number"

    select "Credit Card", from: "Pay type"
    assert has_field? "Credit card number"
    assert has_field? "Expiration date"

    select "Purchase Order", from: "Pay type"
    assert has_field? "Po number"

    fill_in "Po number", with: "1234"
    click_on "Place Order"
    assert_current_path store_index_url
  end
end
