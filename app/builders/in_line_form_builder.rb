class InLineFormBuilder < ActionView::Helpers::FormBuilder
  %w[collection_select password_field text_area check_box select date_select].each do |method_name|
    define_method(method_name) do |field_name, *args|
      @template.content_tag(:span, super)
    end
  end
  
  def text_field(field_name, *args)
    options = args.extract_options!
    
    field_value = object.send(field_name) || 0
    
    if options[:differential]
      @template.content_tag(:span, field_value.to_s + ' + ' + super(options[:differential], *args))
    else
      @template.content_tag(:span, super)
    end
  end
  
  def remove_link(link_name, *args)
    unless object.new_record?
      options = args.extract_options!
      link_name = link_name ||= 'Destroy'
      
      out = ""
      out << hidden_field(:_delete, :class => "delete_field")
      out << @template.link_to_function(link_name, "delete_record(this, '#{object.class.name.underscore}')")
      out
    end
  end
   
  private
  
  def field_required?(field_name)
    object.class.reflect_on_validations_for(field_name).map(&:macro).include?(:validates_presence_of)
  end
  
  def objectify_options(options)
    super.except(:label, :required, :label_class)
  end
end
