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

describe Category do
  let(:category) { FactoryGirl.create(:category) }

  it 'is valid with valid attributes' do
    build(:category).should be_valid
  end

  describe 'relations' do
    it { should belong_to(:parent).class_name('Category') }
    it { should have_many(:subCategories).class_name('Category') }
    it { should have_many :assets }
  end

  describe '#name' do
    it { should validate_presence_of :name }

    it do
      FactoryGirl.create(:category)
      should validate_uniqueness_of(:name).case_insensitive
    end

    it { should ensure_length_of(:name).is_at_least(2).is_at_most(25) }
  end
end
