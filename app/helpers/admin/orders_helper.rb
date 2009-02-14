module Admin::OrdersHelper
  def add_order_line_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, 'order_lines', :partial => 'order_line', :locals => { :form_line => OrderLine.new }
    end
  end
  
  def orderStatusHash
    Hash['WAIT_ESTIMATE',            'Waiting estimate',
         'WAIT_ESTIMATE_VALIDATION', 'Waiting estimate validation',
         'IN_PREPARATION',           'In preparation',
         'WAIT_DELIVERY',            'Waiting delivery',
         'ACHIEVED',                 'Achieved',
         'ORDER_CANCELED',           'Order canceled',
         'ERROR',                    'Error'
        ]
  end
  
  def orderActionHash
    Hash['CREATE_ESTIMATE', 'Create estimate',
         'ACCEPT_ESTIMATE', 'Accept this estimate',
         'REFUSE_ESTIMATE', 'Refuse this estimate',
         'ORDER_PREPARED',  'Order prepared',
         'ORDER_DELIVERED', 'Order delivered']
    
  end
end