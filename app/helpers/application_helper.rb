# Methods added to this helper will be available to all templates in the application.
#require "#{RAILS_ROOT}/config/menus.rb"
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
end
