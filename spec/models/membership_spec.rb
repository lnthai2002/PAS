require 'spec_helper'

describe Membership do
  it 'belongs to many groups' do
    acl = Membership.new
    acl.should be_respond_to(:groups)
  end
  
  it 'belongs to many users' do
    acl = Membership.new
    acl.should be_respond_to(:users)
  end
end