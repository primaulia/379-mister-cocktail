class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  layout 'alternative', only: [:home]

  def home
    if params[:query].present?
      @cocktails = Cocktail.search_by_cocktail_and_user(params[:query])
    else
      @cocktails = Cocktail.all.order(votes: :desc)
    end

    raise if @cocktails.nil?

    @new_cocktail = Cocktail.new

    @markers = @cocktails.map do |cocktail|
      {
        lat: cocktail.user.latitude,
        lng: cocktail.user.longitude
      }
    end.uniq
  end
end
