class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cocktails, dependent: :destroy
  has_many :messages

  # server-side
  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode # if the model is actually saved or not
  # after_create # stuck before validation
end
