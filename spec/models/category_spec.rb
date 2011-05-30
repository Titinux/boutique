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
