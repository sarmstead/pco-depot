require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:description].any?
    assert product.errors[:image].any?
    assert product.errors[:price].any?
    assert product.errors[:title].any?
  end
end
