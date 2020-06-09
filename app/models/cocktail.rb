class Cocktail < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses

  has_one_attached :photo

  belongs_to :user

  include PgSearch::Model
  pg_search_scope :search_by_cocktail_and_user,
    against: { 
      name: 'A', 
      instruction: 'B' 
    },
    associated_against: {
      user: {
        email: 'A', 
        address: 'B'
      }
    },
    using: {
      tsearch: { prefix: true }
    }
end