require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:one)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "should create order" do
    visit store_index_url
    click_on "Add to Cart", match: :first

    visit new_order_url

    fill_in "Address", with: @order.address
    fill_in "Email", with: @order.email
    fill_in "Name", with: @order.name
    select "Check", from: "Pay type"
    click_on "Place Order"

    assert_current_path store_index_url
  end

  test "should update Order" do
    visit order_url(@order)
    click_on "Edit this order", match: :first

    fill_in "Address", with: @order.address
    fill_in "Email", with: @order.email
    fill_in "Name", with: @order.name
    fill_in "Address", with: "123 Easy Street, Royal Oak, Michigan, 48067"
    click_on "Place Order"

    assert_current_path order_url(@order)
  end

  test "should destroy Order" do
    visit order_url(@order)
    accept_confirm { click_on "Destroy this order", match: :first }

    assert_text "Order was successfully destroyed"
  end
end
