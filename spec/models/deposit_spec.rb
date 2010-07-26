require 'spec_helper'

describe Deposit do
  it 'is valid with valid attributes' do
    Factory.build(:deposit).should be_valid
  end

  it 'is not valid without a user' do
    Factory.build(:deposit, :user => nil).should_not be_valid
  end

  it 'is not valid without an asset' do
    Factory.build(:deposit, :asset => nil).should_not be_valid
  end

  describe '#quantity' do
    it 'should not be nil' do
      Factory.build(:deposit, :quantity => nil).should_not be_valid
    end

    it 'should be an integer' do
      Factory.build(:deposit, :quantity => 'toto').should_not be_valid
      Factory.build(:deposit, :quantity => 0.53).should_not be_valid
    end
  end

  describe '#quantity_modifier' do
    it 'should not nil' do
      Factory.build(:deposit, :quantity_modifier => nil).should_not be_valid
    end

    it 'should be an integer' do
      Factory.build(:deposit, :quantity_modifier => 'toto').should_not be_valid
      Factory.build(:deposit, :quantity_modifier => 0.53).should_not be_valid
    end
  end

  it 'should be destroy after save if quantity equal to 0' do
    @deposit = Factory.build(:deposit, :quantity => 0)
    @deposit.save

    @deposit.destroyed?.should == true
  end
end
