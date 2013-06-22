# Boutique is a saleroom website for Dofus resources, originally created
# for the merchant guild "Les Marchands d'Hyze"
# Copyright (C) 2013 - Jérémie Horhant (jeremie dot horhant at titinux dot net)
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

describe Deposit do
  it 'is valid with valid attributes' do
    build(:deposit).should be_valid
  end

  it 'is not valid without a user' do
    build(:deposit, user: nil).should_not be_valid
  end

  it 'is not valid without an asset' do
    build(:deposit, asset: nil).should_not be_valid
  end

  describe '#quantity' do
    it 'should not be nil' do
      build(:deposit, quantity: nil).should_not be_valid
    end

    it 'should be an integer' do
      build(:deposit, quantity: 'toto').should_not be_valid
      build(:deposit, quantity: 0.53).should_not be_valid
    end
  end

  describe '#quantity_modifier' do
    it 'should not nil' do
      build(:deposit, quantity_modifier: nil).should_not be_valid
    end

    it 'should be an integer' do
      build(:deposit, quantity_modifier: 'toto').should_not be_valid
      build(:deposit, quantity_modifier: 0.53).should_not be_valid
    end
  end

  it 'should be destroy after save if quantity equal to 0' do
    @deposit = build(:deposit, quantity: 0, quantity_modifier: 0)
    @deposit.save

    @deposit.destroyed?.should == true
  end
end
