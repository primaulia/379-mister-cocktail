class AddInstructionToCocktails < ActiveRecord::Migration[6.0]
  def change
    add_column :cocktails, :instruction, :string
  end
end
