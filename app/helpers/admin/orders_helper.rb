module Admin::OrdersHelper
  def add_order_line_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, 'order_lines', :partial => 'order_line', :locals => { :form_line => OrderLine.new }
    end
  end
  
  def orderStatusHash
    Hash[0, 'Waiting estimate',
         1, 'Waiting estimate validation',
         2, 'In preparation',
         3, 'Waiting delivery',
         4, 'Achieved']
  end
  
  def orderActionHash
    Hash[0, 'Create estimate',
         1, 'Accept this estimate',
         2, 'Order prepared',
         3, 'Order delivered']
    
  end  
  
  
  def action(order, adminSide = false)
    if adminSide
     
      
    else  
      if order.state == 1
        link_to 
      end
    end
    
  end
end