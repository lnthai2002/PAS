class DropIngredientsRecipes < ActiveRecord::Migration
  def up
    drop_table :ingredients_recipes
  end
  
  def down
    create_table :ingredients_recipes do |t|
      t.column :recipe_id, :integer
      t.column :ingredient_id, :integer
    end
  end
end
