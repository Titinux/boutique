require 'spec_helper'

describe Asset do
  it "is valid with valid attributes" do
    Factory.build(:asset).should be_valid
  end

  describe '#name' do
    it 'should not be empty or nil' do
      Factory.build(:asset, :name => '').should_not be_valid
      Factory.build(:asset, :name => nil).should_not be_valid
    end

    it 'size should be within 2 to 25 characters' do
      Factory.build(:asset, :name => 'f').should_not be_valid
      Factory.build(:asset, :name => 'f'*26).should_not be_valid
    end

    it 'should be unique' do
      @asset = Factory.create(:asset, :name => 'category')
      Factory.build(:asset, :name => @asset.name).should_not be_valid
    end
  end

  it "should belong to a category" do
    Factory.build(:asset, :category => nil).should_not be_valid
  end

  describe '#unitaryPrice' do
    it "should not be nil" do
      Factory.build(:asset, :unitaryPrice => nil).should_not be_valid
    end

    it "must be numerical" do
      Factory.build(:asset, :unitaryPrice => 'foo').should_not be_valid
    end

    it "must be greater or equal to 0" do
      Factory.build(:asset, :unitaryPrice => -1).should_not be_valid
    end
  end
end
