require 'spec_helper'

describe Group do
  it 'may have one or more user' do
    group = Group.new
    group.should be_respond_to(:users)
  end
end