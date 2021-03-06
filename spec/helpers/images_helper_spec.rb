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
    it "convert a true value to a check image with I18n text" do
      xpath = "//img[@title='#{I18n.t('show_for.yes')}' and @alt= '#{I18n.t('show_for.yes')}' and @src='#{path_to_image('actions/yes.png')}']"

      helper.boolean_to_image(true).should have_xpath(xpath)
    end

    it "convert a false value to a cross image with I18n text" do
      xpath = "//img[@title='#{I18n.t('show_for.no')}' and @alt= '#{I18n.t('show_for.no')}' and @src='#{path_to_image('actions/no.png')}']"

      helper.boolean_to_image(false).should have_xpath(xpath)
    end
  end
end
