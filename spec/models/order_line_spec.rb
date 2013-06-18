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

describe OrderLine do
  let(:order) { build(:order) }

  it 'is valid with valid attributes' do
    build(:order_line, :order_id => order.id).should be_valid
  end

  describe 'relations' do
    it { should belong_to :order }
    it { should belong_to :asset }
  end

  describe '#quantity' do
    it { should validate_numericality_of(:quantity).only_integer }

    it 'should be a strict positive number' do
      build(:order_line, order_id: order.id, quantity: 0).should_not be_valid
      build(:order_line, order_id: order.id, quantity: -1).should_not be_valid
    end
  end

  describe '#unitaryPrice' do
    it { should validate_numericality_of(:unitaryPrice) }

    it 'could be nil' do
      build(:order_line, order_id: order.id, unitaryPrice: nil).should be_valid
    end

    it 'should be a positive number' do
      build(:order_line, order_id: order.id, unitaryPrice: -1).should_not be_valid
      build(:order_line, order_id: order.id, unitaryPrice: -12.5).should_not be_valid
    end
  end

  describe '#total' do
    it 'should be quantity times unitaryPrice' do
      build(:order_line, quantity: 5, unitaryPrice: 10).total.should eq(50)
    end
  end
end
