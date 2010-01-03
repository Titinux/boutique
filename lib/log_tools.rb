module LogTools
  def self.log_me(record, *args)
    options = args.extract_options!
    options[:level]      ||= 0
    options[:user]       ||= 'unknow'
    options[:action]     ||= 'unknow'
    options[:objectType] ||= record.class.name
    options[:objectId]   ||= record.id
    options[:data]       ||= record.attributes

    Log.create(:level => options[:level],
               :user => options[:user],
               :action => options[:action],
               :objectType => options[:objectType],
               :objectId => options[:objectId],
               :data => options[:data])
  end
end
