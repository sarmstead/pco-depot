products = Rails.root.join("test", "fixtures", "products.yml")

YAML.load_file(products).each do |name, attributes|
  puts "Creating #{attributes["title"]} ..."

  product = Product.find_or_create_by(title: attributes["title"])
  product.description = attributes["description"]
  product.price = attributes["price"]
  product.image.attach(
    io: File.open(
      Rails.root.join("test", "fixtures", "files", attributes["image"])
    ),
    filename: attributes["title"]
  )
  product.save!

  puts "  > #{attributes["title"]} created! ✅\n\n"
end
