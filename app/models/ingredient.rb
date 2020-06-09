class Ingredient < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :doses
end




# results = PgSearch.multisearch('<query>')
  
# if result.searchable == 'Cocktail'
#   # display Cocktail card
# else
#   # display Ingredient card
# end

# Cocktail instance
# OR
# Ingredient instance