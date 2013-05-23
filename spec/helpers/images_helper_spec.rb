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

describe ImagesHelper do
  describe "boolean_to_image" do
     it "convert a boolean value to an image with I18n text" do
       helper.boolean_to_image(true).should have_selector("img",
                                                          :title => I18n.t('yes'),
                                                          :alt => I18n.t('yes'),
                                                          :src => "/images/actions/yes.png")

       helper.boolean_to_image(false).should have_selector("img",
                                                          :title => I18n.t('no'),
                                                          :alt => I18n.t('no'),
                                                          :src => "/images/actions/no.png")
     end
   end
end
