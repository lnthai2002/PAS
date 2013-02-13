require 'spec_helper'

describe Acl do
  it 'belongs to many groups' do
    acl = Acl.new
    acl.should be_respond_to(:groups)
  end
  
  it 'belongs to many users' do
    acl = Acl.new
    acl.should be_respond_to(:users)
  end
end