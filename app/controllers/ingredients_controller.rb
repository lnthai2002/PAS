class IngredientsController < ApplicationController
  def create
    if not params[:recipe_id].blank?
      create_and_forward_to_recipe
    else
      create_and_go_back_to_show
    end
  end
  
  def destroy
    if not params[:recipe_id].blank?
      delete_and_forward_to_recipe
    else
      delete_and_go_back_to_index
    end
  end
private
  def delete_and_forward_to_recipe
    recipe = Recipe.find(params[:recipe_id])
    ingredient = Ingredient.find(params[:id])
    
    recipe.ingredients.delete(ingredient)#remove this ingredient from the current recipe
    if ingredient.recipes.blank? #no recipe use this ingredient
      ingredient.destroy
    end

    respond_to do |format|
      format.html { redirect_to recipe }
      format.json { head :ok }
    end
  end

  def delete_and_go_back_to_index
    ingredient = Ingredient.find(params[:id])
    if ingredient.recipes.blank? #no recipe use this ingredient
      ingredient.destroy
    else #this ingredient is in used somewhere
      notice = 'This ingredient is still in used, cant remove!'
    end

    respond_to do |format|
      format.html { redirect_to ingredients_path}
      format.json { head :ok }
    end
  end

  def create_and_forward_to_recipe
    @ingredient = Ingredient.new(params[:ingredient])
    recipe = Recipe.find(params[:recipe_id])
    @ingredient.recipes << recipe

    respond_to do |format|
      if @ingredient.save
        format.html { redirect_to recipe, notice: 'An ingredient was successfully added.' }
        format.json { render json: @ingredient, status: :created, location: @ingredient }
      else
        format.html { render action: "new" }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_and_go_back_to_show
    @ingredient = Ingredient.new(params[:ingredient])

    respond_to do |format|
      if @ingredient.save
        format.html { redirect_to @ingredient, notice: 'An ingredient was successfully created.' }
        format.json { render json: @ingredient, status: :created, location: @ingredient }
      else
        format.html { render action: "new" }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end
end
