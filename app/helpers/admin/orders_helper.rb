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
end