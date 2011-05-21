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

module ApplicationHelper
  def block(*args, &block)
    options = args.extract_options!
    options[:class] ||= ''
    options[:body_class] ||= ''

    out = ''
    out << '<div class="block ' + options[:class] + '">'
    out << '<div class="block_header">' + options[:title] + '</div>'
    out << '<div class="block_body ' + options[:body_class] + '">'
    out << capture(&block)
    out << '</div>'
    out << '</div>'

    raw(out)
  end

  def makeMenu(name)
    filename = "#{Rails.root}/config/menus.rb"

    menu = eval(IO.read(filename), binding, filename)

    name.split('.').each {|name_part| menu = menu[name_part.to_sym] }

    out = "<ul>"

    menu.each do |item|
      if (not item.has_key? :condition) or item[:condition]
        out << "<li>"
        out << link_to(item[:name], item[:link], item[:link_opts])
        out << "</li>"
      end
    end

    out << "</ul>"
    raw out
  end

  def my_select_options(container, *args)
    options = args.extract_options!
    options[:include_blank] ||= false
    options[:selected] ||= false

    out = ""
    out << "<option value=\"\"></option>" if options[:include_blank]

    container.each do |item|
      values = {}
      values[:value] = item.last
      values[:selected] = "selected" if item.last.to_s == options[:selected].to_s
      values.merge!(options.except(:include_blank, :selected))

      str_values = []
      values.each {| key, value | str_values += ["#{key.to_s}=\"#{value.to_s}\""] }
      str_values = str_values.join(' ')

      out << "<option "
      out << str_values
      out << ">#{item.first}</option>"
    end

    out.html_safe
  end

  def hash_to_table(source)
    source_a = source.sort

    out = "<table>"

    source_a.each do |item|
      out << "<tr class=\"#{cycle('even', 'odd')}\">"
      out << "<td>#{item[0]}</td>"

      if item[1].is_a? Array
        out << "<td>#{item[1][0]} -> #{item[1][1]}</td>"
      else
        out << "<td>#{item[1]}</td>"
      end
      out << '</tr>'
    end

    out << "</table>"
    out.html_safe
  end

  def content_title(title)
    content_for(:content_title, content_tag(:h2, title))
  end
end
