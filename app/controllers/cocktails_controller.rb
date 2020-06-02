class CocktailsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  # skip_before_action :<method_name>, only: [<action>]


  def index
    # only throw cocktail that belongs to me
    @cocktails = policy_scope(Cocktail)
    
  end

  def show
    @the_cocktail = Cocktail.find(params[:id])
    authorize @the_cocktail
  end

  def new
    @new_cocktail = Cocktail.new
    authorize @new_cocktail
  end

  def create
    @new_cocktail = Cocktail.new(cocktail_params)
    @new_cocktail.user = current_user

    authorize @new_cocktail    
    if @new_cocktail.save
      redirect_to @new_cocktail
    else
      render :new
    end
  end

  def edit
    @cocktail = Cocktail.find(params[:id])
    authorize @cocktail
  end


  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo)
  end
end
