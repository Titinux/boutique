class CustomFormBuilder < ActionView::Helpers::FormBuilder
  %w[collection_select password_field text_area check_box select date_select].each do |method_name|
    define_method(method_name) do |field_name, *args|
      @template.content_tag(:p, field_label(field_name, *args) + super)
    end
  end
  
  def text_field(field_name, *args)
    options = args.extract_options!
    
    if options[:differential]
      @template.content_tag(:p, field_label(options[:differential], *args) + object.send(field_name).to_s + ' + ' + super(options[:differential], *args))
    else
      @template.content_tag(:p, field_label(field_name, *args) + super)
    end
  end
  
  def submit(*args)
    @template.content_tag(:p, super)
  end
   
  def remove_field(*args)
    hidden_field(:_delete, *args)  unless object.new_record?
  end 
   
  private
  
  def field_label(field_name, *args)
    options = args.extract_options!
    options.reverse_merge!(:required => field_required?(field_name))
    options[:label_class] = "required" if options[:required]
    label(field_name, object.class.human_attribute_name(field_name.to_s), :class => options[:label_class])
  end
  
  def field_required?(field_name)
    object.class.reflect_on_validations_for(field_name).map(&:macro).include?(:validates_presence_of)
  end
  
  def objectify_options(options)
    super.except(:label, :required, :label_class)
  end
end
