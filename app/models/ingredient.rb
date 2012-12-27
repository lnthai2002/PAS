class Ingredient < ActiveRecord::Base
  has_and_belongs_to_many :recipes
  #use IngredientImageUploader to upload image and store url to image column
  mount_uploader :image, IngredientImageUploader
end
