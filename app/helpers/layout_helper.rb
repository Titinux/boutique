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

module LayoutHelper
  def render_flash_messages
    out = ''

    flash.each do |name, msg|
      out += content_tag :p, :class => "flash #{name}" do
        flash_message = image_tag "icones/#{name}.png"
        flash_message += content_tag :strong, t("flash.names.#{name}")
        flash_message += ": #{msg}"
        flash_message
      end
    end

    out.html_safe
  end
end
