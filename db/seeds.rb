require 'open-uri'

puts "Setup DB"
# User.destroy_all
# Ingredient.destroy_all

puts "Create 2 users"
User.create(
  email: 'prima@gmail.com', 
  password: 'test123',
  address: '1 Orchard Road Singapore'
)

User.create(
  email: 'guido@gmail.com', 
  password: 'test123',
  address: '1 Fullerton Road Singapore'
)


puts "Create 100 Ingredients by thecocktaildb API"
url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"

raw_json = open(url).read
hash = JSON.parse(raw_json)
drinks = hash["drinks"]

drinks.each do |drink|
  Ingredient.create!(name: drink["strIngredient1"])
end 

puts "Create 5 seeded cocktails"

cocktails_arr = ['Mojito', 'Bloody Mary', 'Sex on the Beach', 'Margarita', 'Pina Colada']

cocktails_arr.each do |cocktail|
  puts "Create #{cocktail} with a photo and attached to a random user"
  the_cocktail = Cocktail.new(name: cocktail)
  the_cocktail.user = User.all.sample
  the_cocktail.save!


  cocktail_url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{the_cocktail.name}"

  cocktail_json = open(cocktail_url).read
  cocktail_data = JSON.parse(cocktail_json)

  thumbnail_url = cocktail_data["drinks"][0]["strDrinkThumb"]

  file = URI.open(thumbnail_url) # downloading to the memory
  the_cocktail.instruction = cocktail_data["drinks"][0]["strInstructions"]
  the_cocktail.save
  the_cocktail.photo.attach(io: file, filename: "#{the_cocktail.name}.jpg", content_type: 'image/jpg')
end

puts "End of seeds"