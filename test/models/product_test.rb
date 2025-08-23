require "test_helper"

class ProductTest < ActiveSupport::TestCase
  setup do
    @product = products(:drill)
  end

  test "product attributes must not be empty" do
    invalid_product = Product.new
    assert invalid_product.invalid?
    assert invalid_product.errors[:description].any?
    assert invalid_product.errors[:image].any?
    assert invalid_product.errors[:price].any?
    assert invalid_product.errors[:title].any?
  end

  test "should be invalid when price is negative" do
    @product.price = -1
    assert @product.invalid?
    assert_equal [ "must be greater than or equal to 0.01" ], @product.errors[:price]
  end

  test "should be invalid when price is zero" do
    @product.price = 0
    assert @product.invalid?
    assert_equal [ "must be greater than or equal to 0.01" ], @product.errors[:price]
  end

  test "should be valid when price is greater than or equal to one cent" do
    @product.price = 0.01
    assert @product.valid?

    @product.price = 0.02
    assert @product.valid?
  end

  test ".png image file extension is valid" do
    assert @product.valid?, "image/png must be valid"
  end

  test ".gif image file extension is valid" do
    @product.image.attach(
      io: File.open(
        file_fixture("test.gif"),
      ),
      filename: "test.gif",
      content_type: "image/gif"
    )
    assert @product.valid?, "image/gif must be valid"
  end

  test ".jpg image file extension is valid" do
    @product.image.attach(
      io: File.open(
        file_fixture("test.jpg"),
      ),
      filename: "test.jpg",
      content_type: "image/jpeg"
    )
    assert @product.valid?, "image/jpeg must be valid"
  end

  test "any image file extension other than .gif, .png, or .jpg is valid" do
    @product.image.attach(
      io: File.open(
        file_fixture("test.svg"),
      ),
      filename: "test.svg",
      content_type: "image/svg"
    )

    assert_not @product.valid?, "image/svg must not be valid"
  end
end
