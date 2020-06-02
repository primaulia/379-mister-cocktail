class CocktailsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  # skip_before_action :<method_name>, only: [<action>]


  def index
    @cocktails = Cocktail.all
  end

  def show
    @the_cocktail = Cocktail.find(params[:id])
  end

  def new
    @new_cocktail = Cocktail.new
  end

  def create
    @new_cocktail = Cocktail.new(cocktail_params)
    @new_cocktail.user = current_user
    
    if @new_cocktail.save
      redirect_to @new_cocktail
    else
      render :new
    end
  end


  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo)
  end
end
