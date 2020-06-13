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
      redirect_to root_path(anchor: 'cocktail-form')
    else
      @cocktails = Cocktail.all
      render 'pages/home'
    end
  end

  def edit
    @cocktail = Cocktail.find(params[:id])
    authorize @cocktail
  end

  def destroy
    @cocktail = Cocktail.find(params[:id])
    authorize @cocktail
    @cocktail.destroy
    redirect_to root_path(anchor: 'cocktail-form')
  end

  def upvote
    # find the cocktail
    # get the vote count
    # +1 the count

    upvoted_cocktail = Cocktail.find(params[:id])
    authorize(upvoted_cocktail)
    if upvoted_cocktail.votes
      upvoted_cocktail.votes += 1
    else
      upvoted_cocktail.votes = 1
    end
    
    if upvoted_cocktail.save
      # redirect to the page that request

      respond_to do |format|
        # format.html #there's a sync request
        format.json { render json: { cocktail: upvoted_cocktail } }
      end
    end
  end


  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo)
  end
end
