require 'spec_helper'

describe CartLine do
  it 'is valid with valid attributes' do
    Factory.build(:cart_line).should be_valid
  end

  describe '#asset' do
    it 'is required' do
      Factory.build(:cart_line, :asset => nil).should_not be_valid
    end
  end

  describe '#quantity' do
    it 'should be greater than 0' do
      Factory.build(:cart_line, :quantity => 0).should_not be_valid
      Factory.build(:cart_line, :quantity => -1).should_not be_valid
    end
  end
end
