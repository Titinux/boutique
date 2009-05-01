# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def generate_html(form_builder, method, options = {})
    options[:object] ||= form_builder.object.class.reflect_on_association(method).klass.new
    options[:partial] ||= method.to_s.singularize + '_form'
    options[:form_builder_local] ||= :f  

    form_builder.fields_for(method, options[:object], :builder => InLineFormBuilder, :child_index => 'NEW_RECORD') do |f|
      content_tag :div, render(:partial => options[:partial], :locals => { options[:form_builder_local] => f }), :class => 'deposite', :id => "user_deposite_NEW_RECORD"
    end
  end

  def generate_template(form_builder, method, options = {})
    escape_javascript generate_html(form_builder, method, options = {})
  end
end
