module ImageHelper
  def boolean_to_image(value, *args)
    options = args.extract_options!
    options[:text] ||= value ? I18n.t('yes') : I18n.t('no')

    image_tag(value ? 'actions/yes.png' : 'actions/no.png', :alt => options[:text], :title => options[:text])

  end
end
