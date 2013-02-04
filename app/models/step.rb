class Step < ActiveRecord::Base
  belongs_to :recipe
  default_scope :order => 'sequence_number'
  before_create :set_sequence_number
  
  #use StepImageUploader to upload image and store url to image column
  mount_uploader :image, StepImageUploader

protected

  def set_sequence_number
    if self.sequence_number.blank?
      self.sequence_number = self.recipe.steps.maximum('sequence_number').to_i + 1
    end
  end
end
