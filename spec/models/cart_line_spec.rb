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

describe CartLine do
  it 'is valid with valid attributes' do
    build(:cart_line).should be_valid
  end

  describe '#asset' do
    it 'is required' do
      build(:cart_line, :asset => nil).should_not be_valid
    end
  end

  describe '#quantity' do
    it 'should be greater than 0' do
      build(:cart_line, :quantity => 0).should_not be_valid
      build(:cart_line, :quantity => -1).should_not be_valid
    end
  end
end
