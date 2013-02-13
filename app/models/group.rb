class Group < ActiveRecord::Base
  attr_accessible :name
  has_many :memberships
  has_many :users, :through=>:membership
  validates :name, :presence=>true
end
