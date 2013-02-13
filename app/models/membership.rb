class Membership < ActiveRecord::Base
  attr_accessible :user_id, :group_id
  belongs_to :users
  belongs_to :groups
end
