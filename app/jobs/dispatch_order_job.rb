class DispatchOrderJob < Struct.new(:order_id)
  def perform
    order = Order.find(order_id)
    OrderTools::dispatch(order)
  end
end