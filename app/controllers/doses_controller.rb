class DosesController < ApplicationController
  def new
    # grab the cocktail instance by the id
    @the_cocktail = Cocktail.find(params[:cocktail_id])

    # build a blank dose instance
    @new_dose = Dose.new
    # associate the blank dose instance with the
    # existing cocktail
    @new_dose.cocktail = @the_cocktail

    # build an instance of dose associated with an existing
    # cocktail
    # @new_dose2 = @the_cocktail.doses.build # Dose.new + .cocktail = <Cocktail instance>
  end

  def create
    @the_cocktail = Cocktail.find(params[:cocktail_id])
    @new_dose = @the_cocktail.doses.build(dose_params)
    
    if @new_dose.save
      redirect_to @the_cocktail
    else
      render :new
    end
  end

  def destroy
    @the_dose = Dose.find(params[:id])
    @the_cocktail = @the_dose.cocktail

    redirect_to @the_cocktail if @the_dose.destroy
  end

  private

  def dose_params
    params.require(:dose).permit([:description, :ingredient_id])
  end
end
