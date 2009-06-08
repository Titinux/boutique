module ActionsHelper
  def link_to_action(link, text, picture, *args)
    options = args.extract_options!
    options[:format] ||= :short
    
    out = []
    
    capture do
      link_to(link, options) do
        out << image_tag(picture, :alt => text, :title => text)
        out << text if options[:format] == :long
        out
      end
    end
  end
  
  def link_to_show(link, *args)
    link_to_action link, t('show'), 'actions/show.png'
  end
  
  def link_to_edit(link, *args)
    link_to_action link, t('edit'), 'actions/edit.png'
  end
  
  def link_to_destroy(link, *args)
    link_to_action link, t('destroy'), 'actions/destroy.png', :confirm => t('destroy_confirm'), :method => :delete
  end
  
  def link_to_add(link, *args)
    options = args.extract_options!
    options[:text] ||= t('new')
    
    link_to_action link, options[:text], 'actions/add.png', options
  end
  
  def link_to_back(link, *args)
    link_to_action link, t('back'), 'actions/left_arrow.png'
  end
end