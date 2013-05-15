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

describe User do
  it 'is valid with valid attributes' do
    build(:user).should be_valid
  end

  describe '#name' do
    it 'should not be empty or nil' do
      build(:user, :name => '').should_not be_valid
      build(:asset, :name => nil).should_not be_valid
    end

    it 'size should be within 3 to 25 characters' do
      build(:user, :name => 'f').should_not be_valid
      build(:user, :name => 'f'*26).should_not be_valid
    end

    it 'should be unique' do
      @user = create(:user, :name => 'user')
      build(:user, :name => 'user').should_not be_valid
      build(:user, :name => 'User').should_not be_valid
    end
  end

  describe '#email' do
    it "should not be nil" do
      build(:user, :email => nil).should_not be_valid
    end

    it 'should be well formed' do
      %w(foo foo.bar.net foo@ foo@net @net foo,foo@bar.net).each do |value|
        build(:user, :email => value).should_not be_valid
      end
    end

    it 'should be unique' do
      @user = create(:user, :email => 'user@foo.bar')
      build(:user, :email => 'user@foo.bar').should_not be_valid
      build(:user, :email => 'User@Foo.Bar').should_not be_valid
    end
  end

  describe "#password" do
    it 'should not be nil at the creation' do
      build(:user, :password => nil).should_not be_valid
    end

    it 'could be nil in update' do
      @user = create(:user)
      @user.name += 'foo'
      @user.password = nil
      @user.password_confirmation = nil
      @user.should be_valid
    end

    it 'length should be within 6 and 128 characters' do
      build(:user, :password => 'f'*5).should_not be_valid
      build(:user, :password => 'f'*129).should_not be_valid
    end
  end

  it 'is not valid if password_confirmation does not match the password' do
    build(:user, :password_confirmation => 'foo').should_not be_valid
  end
end
