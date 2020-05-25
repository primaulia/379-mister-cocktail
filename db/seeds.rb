require 'open-uri'

puts "Setup DB"
Ingredient.destroy_all
Cocktail.destroy_all

puts "Create 100 Ingredients by thecocktaildb API"
url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"

raw_json = open(url).read
hash = JSON.parse(raw_json)
drinks = hash["drinks"]

drinks.each do |drink|
  Ingredient.create!(name: drink["strIngredient1"])
end 

puts "Create 5 seeded cocktails"

Cocktail.create!(name: 'Mojito')
Cocktail.create!(name: 'Bloody Mary')
Cocktail.create!(name: 'Sex on the Beach')
Cocktail.create!(name: 'Margarita')
Cocktail.create!(name: 'Pina Colada')

puts "End of seeds"