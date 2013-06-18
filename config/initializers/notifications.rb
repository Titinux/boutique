ActiveSupport::Notifications.subscribe "state_changed.order.dofus_shop" do |name, start, finish, id, payload|
  Rails.logger.debug "Order ##{payload[:order_id]} receive #{payload[:event]} and switch state from #{payload[:from]} to #{payload[:to]}"
end
