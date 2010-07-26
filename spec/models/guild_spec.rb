require 'spec_helper'

describe Guild do
  it 'is valid with valid attributes' do
    Factory.build(:guild).should be_valid
  end

  describe '#name' do
    it 'should not be empty or nil' do
      Factory.build(:guild, :name => '').should_not be_valid
      Factory.build(:guild, :name => nil).should_not be_valid
    end

    it 'size should be within 2 to 25 characters' do
      Factory.build(:guild, :name => 'f').should_not be_valid
      Factory.build(:guild, :name => 'f'*26).should_not be_valid
    end

    it 'should be unique' do
      @guild = Factory.create(:guild, :name => 'category')
      Factory.build(:guild, :name => @guild.name).should_not be_valid
    end
  end
end
