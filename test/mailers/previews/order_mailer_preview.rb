class OrderMailerPreview < ActionMailer::Preview
  # http://localhost:3000/rails/mailers/order_mailer/received
  def received
    OrderMailer.received(order)
  end

  # http://localhost:3000/rails/mailers/order_mailer/shipped
  def shipped
    OrderMailer.shipped(order)
  end

  def order
    @order ||= begin
      Order.first if Order.first.exists?

      Order.create
    end
  end

  def order
    @order ||= begin
      order = Order.find_by(name: "Kristen Walker")

      return order if order

      order = Order.new(
        name: "Kristen Walker",
        email: "kristen@example.net",
        address: "12345 Constitution Avenue, New York, 157890",
        pay_type: "check"
      )
      order.add_line_items_from_cart(cart)
      order.save!
      order
    end
  end

  def cart
    @cart ||= begin
      cart = Cart.new
      cart.line_items << line_item
      cart.save!
      cart
    end
  end

  def line_item
    @line_item ||= begin
      line_item = LineItem.find_by(product_id: product.id)

      return line_item if line_item

      line_item = LineItem.new(product_id: product.id)
      line_item
    end
  end

  def product
    @product ||= begin
      product_seeds_path = Rails.root.join("db", "seeds", "products.yml")
      driver_set_seed = YAML.load_file(product_seeds_path)["driver_set"]
      driver_set = Product.find_by(title: driver_set_seed["title"])

      return driver_set if driver_set

      product = Product.new(title: driver_set["title"])
      product.description = driver_set_seed["description"]
      product.price = driver_set_seed["price"]
      product.image.attach(
        io: File.open(
          Rails.root.join("db", "seeds", driver_set_seed["image"])
        ),
        filename: driver_set_seed["title"]
      )
      product.save!
      product
    end
  end
end
