class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  def home
    @cocktails = Cocktail.all

    @markers = @cocktails.map do |cocktail|
      {
        lat: cocktail.user.latitude,
        lng: cocktail.user.longitude
      }
    end.uniq
  end
end
