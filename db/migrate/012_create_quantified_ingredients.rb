class CreateQuantifiedIngredients < ActiveRecord::Migration
  def change
    create_table :quantified_ingredients do |t|
      t.column :recipe_id, :integer
      t.column :ingredient_id, :integer
      t.column :quantity, :string, :limit=>100
      t.timestamps
    end
  end
end
