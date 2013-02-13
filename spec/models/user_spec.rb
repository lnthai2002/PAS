require 'spec_helper'

describe User do
  it 'should set salt before validation on create' do
    user = User.create
    user.encryption_salt.should_not be_blank
  end

  it 'should encrypt password before save' do
    user = User.new(:password=>'myl@mepassw0rd')
    user.save
    user.encrypted_password.should_not be_blank
  end

  it 'should not update password if password is blank' do
    user = User.create(:password=>'myl@mepassw0rd')
    old_pass = user.encrypted_password
    user.update_attributes(:password=>'')
    updated_user = User.find(user.id) #workaroud activerecord cache
    updated_user.encrypted_password.should == old_pass
  end

  it 'belongs to one or more groups' do
    user = User.new
    user.should be_respond_to(:groups)
  end
end