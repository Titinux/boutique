require 'spec_helper'

describe Category do
  it 'is valid with valid attributes' do
    Factory.build(:category).should be_valid
  end

  describe '#name' do
    it 'should not be empty or nil' do
      Factory.build(:category, :name => '').should_not be_valid
      Factory.build(:category, :name => nil).should_not be_valid
    end

    it 'size should be within 2 to 25 characters' do
      Factory.build(:category, :name => 'f').should_not be_valid
      Factory.build(:category, :name => 'f'*26).should_not be_valid
    end

    it 'should be unique' do
      @category = Factory.create(:category, :name => 'category')
      Factory.build(:category, :name => @category.name).should_not be_valid
    end
  end
end
