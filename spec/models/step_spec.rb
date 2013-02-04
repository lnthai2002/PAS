require 'spec_helper'

describe Step do
  it 'must belong to a recipe' do
    step = Step.new
    step.should be_respond_to(:recipe)
  end
  
  it 'should have an image' do
    step = Step.new
    step.should be_respond_to(:image)
  end

  it 'must be created in sequence' do
    recipe = FactoryGirl.create(:recipe)
    step = FactoryGirl.build(:step, :recipe=>recipe)
    step.save
    step.sequence_number.should == 1
  end
end