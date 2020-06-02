class CocktailPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # if @user.admin? e.g role-based auth
        
      # else
        
      # end
      scope.where(user: @user)
    end
  end

  def create?
    true 
    # allow EVERYONE who are AUTHENTICATED to create
  end

  def show?
    true
    # allow EVERYONE who are AUTHENTICATED to show
  end

  def update?
    # @user == current_user from DEVISE
    # @record == the cocktail instance ==> CocktailPolicy
    @user == @record.user

    # only the CREATOR of the COCKTAIL can edit
    
    # if @user == @record.user
    #   return true
    # else
    #   return false
    # end
  end
end
