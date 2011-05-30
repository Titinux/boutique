# Boutique is a saleroom website for Dofus resources, originally created
# for the merchant guild "Les Marchands d'Hyze"
# Copyright (C) 2011 - Jérémie Horhant (jeremie dot horhant at titinux dot net)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

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
