module Admin::OrdersHelper
  def add_order_line_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, 'order_lines', :partial => 'order_line', :locals => { :form_line => OrderLine.new }
    end
  end
  
  def orderStatusHash
    Hash['WAIT_ESTIMATE',            t('order.state.waitEstimate'),
         'WAIT_ESTIMATE_VALIDATION', t('order.state.waitEstimateValidation'),
         'IN_PREPARATION',           t('order.state.preparation'),
         'WAIT_DELIVERY',            t('order.state.waitDelivery'),
         'ACHIEVED',                 t('order.state.achieved'),
         'ORDER_CANCELED',           t('order.state.canceled'),
         'ERROR',                    t('order.state.error')
        ]
  end
  
  def orderActionHash
    Hash['CREATE_ESTIMATE', t('order.action.create'),
         'ACCEPT_ESTIMATE', t('order.action.accept'),
         'REFUSE_ESTIMATE', t('order.action.refuse'),
         'ORDER_PREPARED',  t('order.action.prepared'),
         'ORDER_DELIVERED', t('order.action.delivered')]
    
  end
end