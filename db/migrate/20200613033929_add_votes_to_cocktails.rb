class AddVotesToCocktails < ActiveRecord::Migration[6.0]
  def change
    add_column :cocktails, :votes, :integer
  end
end
