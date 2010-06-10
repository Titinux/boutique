module Admin::OrdersHelper
  def orderStatusHash
    Hash['WAIT_ESTIMATE',            I18n.t('order.state.waitEstimate'),
         'WAIT_ESTIMATE_VALIDATION', I18n.t('order.state.waitEstimateValidation'),
         'IN_PREPARATION',           I18n.t('order.state.preparation'),
         'WAIT_DELIVERY',            I18n.t('order.state.waitDelivery'),
         'ACHIEVED',                 I18n.t('order.state.achieved'),
         'ORDER_CANCELED',           I18n.t('order.state.canceled'),
         'ERROR',                    I18n.t('order.state.error')
        ]
  end

  def orderActionHash
    Hash['CREATE_ESTIMATE', I18n.t('order.action.create'),
         'ACCEPT_ESTIMATE', I18n.t('order.action.accept'),
         'REFUSE_ESTIMATE', I18n.t('order.action.refuse'),
         'ORDER_PREPARED',  I18n.t('order.action.prepared'),
         'ORDER_DELIVERED', I18n.t('order.action.delivered')
        ]
  end
end
