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
end
