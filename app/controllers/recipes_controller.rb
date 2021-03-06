class RecipesController < ApplicationController
  #Service
  set_tab :cooking
  #Resource tab
  set_tab :all, :recipes
  #sub-tab, each sub-tab coresponse to one action, they belong to the namespace 'recipe_actions'
  set_tab :add, :recipe_actions, :only => %w(new)
  set_tab :edit, :recipe_actions, :only => %w(edit)
  set_tab :list, :recipe_actions, :only => %w(index)
  set_tab :show, :recipe_actions, :only => %w(show)
  # GET /recipes
  # GET /recipes.json
  def index
    @recipes = Recipe.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recipes }
    end
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
    @recipe = Recipe.find(params[:id])
    @step = @recipe.steps.build #build a new step, this new one does not have sequence_id YET
    @ingredient = @recipe.ingredients.build #build new ingredient

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recipe }
    end
  end

  # GET /recipes/new
  # GET /recipes/new.json
  def new
    @recipe = Recipe.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recipe }
    end
  end

  # GET /recipes/1/edit
  def edit
    @recipe = Recipe.find(params[:id])
    @step = @recipe.steps.build #build a new step, this new one does not have sequence_id YET
    @quantified_ingredient = @recipe.quantified_ingredients.build #build new ingredient
    @quantified_ingredient.ingredient = Ingredient.new
  end

  # POST /recipes
  # POST /recipes.json
  def create
    @recipe = Recipe.new(params[:recipe])

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to edit_recipe_path(@recipe), notice: 'Recipe was successfully created.' }
        format.json { render json: @recipe, status: :created, location: @recipe }
      else
        format.html { render action: "new" }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recipes/1
  # PUT /recipes/1.json
  def update
    @recipe = Recipe.find(params[:id])

    respond_to do |format|
      if @recipe.update_attributes(params[:recipe])
        format.html { redirect_to edit_recipe_path(@recipe), notice: 'Recipe was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_url }
      format.json { head :ok }
    end
  end
end
