ActiveSupport::Notifications.subscribe /\.event$/ do |name, start, finish, id, payload|
  EventWorker.perform_async(name, start, finish, id, payload)
end
