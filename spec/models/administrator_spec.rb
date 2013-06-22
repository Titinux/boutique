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

describe Administrator do
  let(:administrator) { FactoryGirl.create(:administrator) }

  it 'is valid with valid attributes' do
    build(:administrator).should be_valid
  end

  describe '#name' do
    it { should validate_presence_of :name }

    it do
      FactoryGirl.create(:administrator)
      should validate_uniqueness_of(:name).case_insensitive
    end

    it { should ensure_length_of(:name).is_at_least(3).is_at_most(25) }
  end

  describe '#email' do
    it { should validate_presence_of :email }

    it do
      FactoryGirl.create(:administrator)
      should validate_uniqueness_of(:email).case_insensitive
    end

    it 'should be well formed' do
      %w(foo foo.bar.net foo@ foo@net @net foo,foo@bar.net).each do |value|
        build(:administrator, email: value).should_not be_valid
      end
    end
  end

  describe "#password" do
    it { should validate_presence_of :password }

    it 'length is between 6 and 128' do
      build(:administrator, password: 'f'*5).should_not be_valid
      build(:administrator, password: 'f'*129).should_not be_valid
    end

    it 'could be nil in update' do
      @administrator = create(:administrator)
      @administrator.name += 'foo'
      @administrator.password = nil
      @administrator.password_confirmation = nil
      @administrator.should be_valid
    end
  end

  it 'is not valid if password_confirmation does not match the password' do
    build(:administrator, password_confirmation: 'foo').should_not be_valid
  end
end
