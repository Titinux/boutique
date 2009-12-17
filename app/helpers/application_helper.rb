# Methods added to this helper will be available to all templates in the application.
#require "#{RAILS_ROOT}/config/menus.rb"
module ApplicationHelper
  def generate_html(form_builder, method, options = {})
    options[:object] ||= form_builder.object.class.reflect_on_association(method).klass.new
    options[:partial] ||= method.to_s.singularize + '_form'
    options[:form_builder_local] ||= :f

    form_builder.fields_for(method, options[:object], :builder => InLineFormBuilder, :child_index => 'NEW_RECORD') do |f|
      content_tag :div, render(:partial => options[:partial], :locals => { options[:form_builder_local] => f }), :class => 'Deposit', :id => "user_Deposit_NEW_RECORD"
    end
  end

  def generate_template(form_builder, method, options = {})
    escape_javascript generate_html(form_builder, method, options = {})
  end

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

    concat out
  end

  def makeMenu(name)
    filename = "#{RAILS_ROOT}/config/menus.rb"

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

    out
  end
end
