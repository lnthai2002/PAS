class Recipe < ActiveRecord::Base
  has_many :steps, :dependent=>:destroy
  has_many :quantified_ingredients
  has_many :ingredients, :through=>:quantified_ingredients
  accepts_nested_attributes_for :steps,:reject_if => lambda { |attrs| attrs.all? { |key, value| value.blank? }}
  accepts_nested_attributes_for :quantified_ingredients,:reject_if => lambda { |attrs| attrs.all? { |key, value| value.blank? }}
  #Use RecipeImageUploader to upload image and record path to image column
  mount_uploader :image, RecipeImageUploader
end
