class QuantifiedIngredientsController < ApplicationController
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
  def create_and_forward_to_recipe
    quantified_ingredient = QuantifiedIngredient.new(params[:quantified_ingredient])
    quantified_ingredient.recipe_id = params[:recipe_id]
    respond_to do |format|
      if quantified_ingredient.save
        format.html { redirect_to "/recipes/#{params[:recipe_id]}/edit", notice: 'An ingredient was successfully added.' }
        format.json { render json: quantified_ingredient, status: :created, location: quantified_ingredient }
      else
        format.html { render action: "new" }
        format.json { render json: quantified_ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_and_forward_to_recipe
    #TODO: also remove ingredient if there is no quantifiedIngrdient associate with it
    QuantifiedIngredient.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to "/recipes/#{params[:recipe_id]}/edit" }
      format.json { head :ok }
    end
  end
end