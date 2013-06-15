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
  def link_to_action(link, text, picture, *args)
    options = args.extract_options!
    options[:format] ||= :short

    link_to(link, options.except(:format, :text)) do
      out = "<i class=\"#{picture} action\" title=\"#{options[:text]}\"></i>"
      out << ' ' + text if options[:format] == :long
      out.html_safe
    end
  end

  def link_to_show(link, *args)
    options = args.extract_options!
    options[:text] ||= t('show')

    link_to_action link, options[:text], 'imoon-search ', options
  end

  def link_to_edit(link, *args)
    options = args.extract_options!
    options[:text] ||= t('edit')

    link_to_action link, options[:text], 'imoon-pencil-2', options
  end

  def link_to_destroy(link, *args)
    options = args.extract_options!
    options[:text] ||= t('destroy')
    options[:data] = { confirm: t('destroy_confirm') }.merge(options[:data] || {})
    options[:method] = :delete

    link_to_action link, options[:text], 'imoon-remove-2', options
  end

  def link_to_add(link, *args)
    options = args.extract_options!
    options[:text] ||= t('new')

    link_to_action link, options[:text], 'imoon-plus', options
  end

  def link_to_back(link, *args)
    options = args.extract_options!
    options[:text] ||= t('back')

    link_to_action link, options[:text], 'imoon-arrow-left-3', options
  end
end
