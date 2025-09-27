products = Rails.root.join("db", "seeds", "products.yml")

YAML.load_file(products).each do |name, attributes|
  puts "Creating #{attributes["title"]} ..."

  product = Product.find_or_create_by(title: attributes["title"])
  product.description = attributes["description"]
  product.price = attributes["price"]
  product.image.attach(
    io: File.open(
      Rails.root.join("db", "seeds", attributes["image"])
    ),
    filename: attributes["title"]
  )
  product.save!

  puts "  > #{attributes["title"]} created! ✅\n\n"
end

User.create!(
  first_name: "Al",
  last_name: "Borland",
  email: "aborland@pcodepot.com",
  password: Rails.application.credentials.base_user.password
)
