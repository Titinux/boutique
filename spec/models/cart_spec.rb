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

describe Cart do
  it 'is valid with valid attributes' do
    build(:cart).should be_valid
  end

  it 'when it is destroyed it must also destroy corresponding lines' do
    proc do
      cart = create(:cart)
      create(:cart_line, { cart: cart })
      create(:cart_line, { cart: cart })

      cart.destroy
    end.should_not change(CartLine, :count)
  end

  describe '#user' do
    it 'should not be nil' do
      build(:cart, user: nil).should_not be_valid
    end
  end

  describe '#name' do
    it 'should not be empty or nil' do
      build(:cart, name: '').should_not be_valid
      build(:cart, name: nil).should_not be_valid
    end

    it 'size should be within 2 to 30 characters' do
      build(:category, name: 'f').should_not be_valid
      build(:category, name: 'f'*31).should_not be_valid
    end

    it 'should be unique for a user' do
      @user1 = create(:user)
      @user2 = create(:user)

      @cart = create(:cart, user: @user1, name: 'My cart')

      build(:cart, user: @user1, name: @cart.name).should_not be_valid
      build(:cart, user: @user2, name: @cart.name).should be_valid
    end
  end
end
