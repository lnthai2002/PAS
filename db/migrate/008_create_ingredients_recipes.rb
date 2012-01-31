class CreateIngredientsRecipes < ActiveRecord::Migration
  def up
    create_table :ingredients_recipes do |t|
      t.column :recipe_id, :integer
      t.column :ingredient_id, :integer
    end
  end

  def down
    drop_table :ingredients_recipes
  end
end
