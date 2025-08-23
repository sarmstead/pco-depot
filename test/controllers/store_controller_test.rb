require "test_helper"

class StoreControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:drill)
  end

  test "should get index and display some products" do
    get store_index_url
    assert_response :success
    assert_select "nav li", minimum: 3
    assert_select "h1", "Products"
    assert_select "h2", @product.title
    assert_select "p", /\$[,\d]+\.\d\d/
  end
end
