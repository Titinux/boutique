require 'spec_helper'

describe Order do
  it 'is valid with valid attributes' do
    Factory.build(:order).should be_valid
  end

  it 'should belongs to a user' do
    Factory.build(:order, :user => nil).should_not be_valid
  end

  it 'should have at least one order line' do
    Factory.build(:order, :lines => []).should_not be_valid
  end
end
