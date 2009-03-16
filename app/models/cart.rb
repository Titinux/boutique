class Cart
  def initialize(session)
    session[:cart] ||= []
    @cart = session[:cart]
  end

  def cart
    @cart.clone
  end
  
  def empty_cart
    @cart.replace []
  end
  
  def line(asset_id)
    asset_id = asset_id.to_i
    
    @cart.select { |cart_item| cart_item[0] == asset_id }.first.clone
  end
  
  def add_line(asset_id, quantity)
    asset_id = asset_id.to_i
    quantity = quantity.to_i
    
    @cart.each do |cart_item|
      if cart_item[0] == asset_id
        cart_item[1] += quantity
        return
      end
    end
    
    @cart << [asset_id, quantity]
  end
  
  def edit_line(asset_id, quantity)
    asset_id = asset_id.to_i
    quantity = quantity.to_i
    
    @cart.select { |cart_item| cart_item[0] == asset_id }.first[1] = quantity
  end
   
  def drop_line(asset_id)
    asset_id = asset_id.to_i
    
    @cart.delete_if do |cart_item|
      cart_item[0] == asset_id
    end
  end
  
  def to_order(user_session)
    @cart.delete_if {|cartLine| cartLine[1].to_i < 1 }
    
    raise "You must be logged to make an order" unless user_session.login?
    raise "It\'s impossible to make an empty order !" if cart.empty?
    
    order = Order.new({ :user => user_session.user, :state => 'WAIT_ESTIMATE'})
    
    cart.each do |cart_line|
      orderLine = order.orderLines.build({:asset_id => cart_line[0], :quantity => cart_line[1], :unitaryPrice => 0})
    end
    
    order.save
    empty_cart
  end
end
