require 'spec_helper'

describe Recipe do
  it 'must have many steps' do
    recipe = Recipe.new
    recipe.should be_respond_to(:steps)
  end

  it 'have steps sorted by sequence number by default' do
    recipe = FactoryGirl.build(:recipe)

    step1 = FactoryGirl.build(:step, :sequence_number=>1)
    step2 = FactoryGirl.build(:step, :sequence_number=>2)
    recipe.steps << step2
    recipe.steps << step1

    recipe.save
    r = Recipe.find(recipe.id)
    r.steps.should == [step1, step2]
  end

  it 'must have many ingredients' do
    recipe = Recipe.new
    recipe.should be_respond_to(:ingredients)
  end

  it 'must have many quanitified ingredients' do
    recipe = Recipe.new
    recipe.should be_respond_to(:quantified_ingredients)
  end

  it 'can have an image' do
    recipe = Recipe.new
    recipe.should be_respond_to(:image)
  end
end
