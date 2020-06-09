class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  def home
    if params[:query].present?
      # @cocktails = Cocktail.where(name: params[:query]) #CASE SENSITIVE SEARCH
      # @cocktails = Cocktail.where("name ILIKE ?", "%#{params[:query]}%") #CASE INSENSITIVE SEARCH + PARTIAL TEXT

      # CASE INSENSITIVE SEARCH + PARTIAL TEXT + MULTIPLE COLUMNS SAME TABLE
      # command = "name ILIKE :query OR <second_column> ILIKE :query"
      # @cocktails = Cocktail.where(command, query: "%#{params[:query]}%")

      # CASE INSENSITIVE SEARCH + PARTIAL TEXT + JOINED TABLE
      # sql_query = " \
      #   cocktails.name @@ :query \
      #   OR users.email @@ :query \
      # "                                                          # sex beach
      # @cocktails = Cocktail.joins(:user).where(sql_query, query: "%#{params[:query]}%")

      @cocktails = Cocktail.search_by_cocktail_and_user(params[:query]) #pg search ==> see `cocktail.rb`
    else
      @cocktails = Cocktail.all
    end


    @markers = @cocktails.map do |cocktail|
      {
        lat: cocktail.user.latitude,
        lng: cocktail.user.longitude
      }
    end.uniq
  end
end
