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

    field_text = object.class.human_attribute_name(field_name.to_s)

    object.class.reflect_on_all_associations.each do |assoc|
      if assoc.name.to_s + '_id' == field_name.to_s
        field_text = assoc.klass.model_name.human
        break
      end
    end

    label(field_name, field_text, :class => options[:label_class])
  end

  def field_required?(field_name)
    object.class.reflect_on_validations_for(field_name).map(&:macro).include?(:validates_presence_of)
  end

  def objectify_options(options)
    super.except(:label, :required, :label_class)
  end
end
