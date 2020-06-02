class AddUserToCocktails < ActiveRecord::Migration[6.0]
  def change
    # add column user_id
    # to table cocktails
    add_reference :cocktails, :user, foreign_key: true 
  end
end
