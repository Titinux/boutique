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

    flash.to_hash.slice(:notice, :warning, :alert).each do |name, msg|
      css_class = case name
        when :notice then 'alert-success'
        when :alert  then 'alert-error'
      end

      out += content_tag :div, :class => "alert #{name} #{css_class}" do
        flash_message  = content_tag :button, '&times;'.html_safe, class: 'close', data: { dismiss: 'alert'}
        flash_message += image_tag "icones/#{name}.png"
        flash_message += content_tag :strong, t("flash.names.#{name}")
        flash_message += ": #{msg}"
        flash_message
      end
    end

    out.html_safe
  end

  def content_title(title, &block)
    content_for(:content_title, content_tag(:h2, title))
  end

  def sidebar(&block)
    content_for(:sidebar, &block)
  end
end
