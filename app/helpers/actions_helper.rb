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

module ActionsHelper
  include FontAwesome::Sass::Rails::ViewHelpers
  include ActionView::Helpers::TranslationHelper

  def link_to_show(link, *args)
    options = args.extract_options!
    options[:icon] ||= 'search'
    options[:text] ||= t('show')

    link_to_action options[:text], link, options
  end

  def link_to_new(link, *args)
    options = args.extract_options!
    text = options.delete(:text) || t('create')

    options[:icon] ||= 'plus'

    link_to_action text, link, options
  end

  def link_to_add(link, *args)
    options = args.extract_options!
    text = options.delete(:text) || t('add')

    options[:icon] ||= 'plus'

    link_to_action text, link, options
  end

  def link_to_edit(link, *args)
    options = args.extract_options!
    text = options.delete(:text) || t('edit')

    options[:icon] ||= 'edit'

    link_to_action text, link, options
  end

  def link_to_sort(link, *args)
    options = args.extract_options!
    text = options.delete(:text) || t('sort')

    options[:icon] ||= 'random'

    link_to_action text, link, options
  end

  def link_to_destroy(link, *args)
    options = args.extract_options!
    text = options.delete(:text) || t('destroy')

    options[:data] ||= {}
    options[:data][:method] ||= :delete
    options[:data][:confirm] ||= t('destroy_confirm')

    options[:icon] ||= 'trash'

    link_to_action text, link, options
  end

  def link_to_event(link, *args)
    options = args.extract_options!
    text = options.delete(:text) || t('action')

    options[:icon] ||= 'bolt'

    link_to_action text, link, options
  end

  def link_to_back(link, *args)
    options = args.extract_options!
    text = options.delete(:text) || t('back')

    options[:icon] ||= 'arrow-left'

    link_to_action text, link, options
  end

  def link_to_action(text, link, *args)
    options = args.extract_options!
    icon = options.delete(:icon)

    out = ''
    out += icon(icon) if icon.present?
    out += text unless options[:format] == :icon_only

    capture do
      link_to out.html_safe, link, options
    end
  end

  def dropdown_menu(id, &block)
    capture do
      haml_tag 'button.button.dropdown.tiny', data: { dropdown: "drop#{id}" } do
        concat icon('wrench')
      end

      haml_tag "ul#drop#{id}.f-dropdown", data: { 'dropdown-content' => true }, tabindex: -1 do
        concat capture(&block)
      end
    end
  end
end
