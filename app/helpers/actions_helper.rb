module ActionsHelper
  def link_to_action(link, text, picture, *args)
    options = args.extract_options!
    options[:format] ||= :short

    out = ''

    capture do
      link_to(link, options.except(:format, :text)) do
        out << image_tag(picture, :alt => text, :title => text)
        out << text if options[:format] == :long
        out
      end
    end
  end

  def link_to_show(link, *args)
    options = args.extract_options!
    options[:text] ||= t('show')

    link_to_action link, options[:text], 'actions/show.png', options
  end

  def link_to_edit(link, *args)
    options = args.extract_options!
    options[:text] ||= t('edit')

    link_to_action link, options[:text], 'actions/edit.png', options
  end

  def link_to_destroy(link, *args)
    options = args.extract_options!
    options[:text] ||= t('destroy')
    options[:confirm] = t('destroy_confirm')
    options[:method] = :delete

    link_to_action link, options[:text], 'actions/destroy.png', options
  end

  def link_to_add(link, *args)
    options = args.extract_options!
    options[:text] ||= t('new')

    link_to_action link, options[:text], 'actions/add.png', options
  end

  def link_to_back(link, *args)
    options = args.extract_options!
    options[:text] ||= t('back')

    link_to_action link, options[:text], 'actions/left_arrow.png', options
  end
end
