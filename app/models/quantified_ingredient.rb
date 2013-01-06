class QuantifiedIngredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ingredient
  accepts_nested_attributes_for :ingredient,:reject_if => lambda { |attrs| attrs.all? { |key, value| value.blank? }}
end