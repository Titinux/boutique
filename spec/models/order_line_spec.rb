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

describe OrderLine do
  before(:each) do
    @order = Factory :order
  end

  it 'is valid with valid attributes' do
    Factory.build(:order_line, :order_id => @order.id).should be_valid
  end

  it 'should have an asset' do
    Factory.build(:order_line, :order_id => @order.id, :asset_id => nil).should_not be_valid
  end

  describe '#quantity' do
    it 'should be a strict positive number' do
      Factory.build(:order_line, :order_id => @order.id, :quantity => 0).should_not be_valid
      Factory.build(:order_line, :order_id => @order.id, :quantity => -1).should_not be_valid
    end

    it 'should be an integer' do
      Factory.build(:order_line, :order_id => @order.id, :quantity => 12.5).should_not be_valid
    end
  end

  describe '#unitaryPrice' do
    it 'could be nil' do
      Factory.build(:order_line, :order_id => @order.id, :unitaryPrice => nil).should be_valid
    end

    it 'should be a positive number' do
      Factory.build(:order_line, :order_id => @order.id, :unitaryPrice => -1).should_not be_valid
      Factory.build(:order_line, :order_id => @order.id, :unitaryPrice => -12.5).should_not be_valid
    end

    it 'should be a float number' do
      Factory.build(:order_line, :order_id => @order.id, :unitaryPrice => 12.5).should be_valid
    end
  end

  describe '#price' do
    it 'should be quantity times unitaryPrice' do
      Factory.build(:order_line, :order_id => @order.id, :quantity => 5, :unitaryPrice => 10).price.should eq(50)
    end
  end
end
