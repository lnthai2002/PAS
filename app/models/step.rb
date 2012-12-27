class Step < ActiveRecord::Base
  belongs_to :recipe
  default_scope :order => 'sequence_number'
  
  #use StepImageUploader to upload image and store url to image column
  mount_uploader :image, StepImageUploader
end
