require 'spec_helper'

describe Ingredient do
  it 'should belongs to a recipe' do
    ingredient = Ingredient.new
    ingredient.should be_respond_to(:recipes)
  end

  it 'should have an image' do
    ingredient = Ingredient.new
    ingredient.should be_respond_to(:image)
  end
end