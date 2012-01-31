class Recipe < ActiveRecord::Base
  has_many :steps, :dependent=>:destroy
  has_and_belongs_to_many :ingredients
  accepts_nested_attributes_for :steps,:reject_if => lambda { |attrs| attrs.all? { |key, value| value.blank? }}
end
