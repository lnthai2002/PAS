class Step < ActiveRecord::Base
  belongs_to :recipe
  default_scope :order => 'sequence_number'
end
