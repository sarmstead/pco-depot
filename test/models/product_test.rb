require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "product attributes must not be empty" do
    invalid_product = Product.new
    assert invalid_product.invalid?
    assert invalid_product.errors[:description].any?
    assert invalid_product.errors[:image].any?
    assert invalid_product.errors[:price].any?
    assert invalid_product.errors[:title].any?
  end

  test "should be invalid when price is negative" do
    product.price = -1
    assert product.invalid?
    assert_equal [ "must be greater than or equal to 0.01" ], product.errors[:price]
  end

  test "should be invalid when price is zero" do
    product.price = 0
    assert product.invalid?
    assert_equal [ "must be greater than or equal to 0.01" ], product.errors[:price]
  end

  test "should be valid when price is greater than or equal to one cent" do
    product.price = 0.01
    assert product.valid?

    product.price = 0.02
    assert product.valid?
  end

  private

  def product
    @product ||= begin
      product = Product.new(title: "Power Gloves", description: "Pro rated work gloves with fire protection.")
      product.image.attach(
        io: File.open(
          file_fixture("power-gloves.png")
        ),
        filename: "power-gloves.png"
      )
      product
    end
  end
end
