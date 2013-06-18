class ConvertOrderStates < ActiveRecord::Migration
  def up
    Order.where(state: 'WAIT_ESTIMATE').update_all            state: 'quotation'
    Order.where(state: 'WAIT_ESTIMATE_VALIDATION').update_all state: 'quote_validation'
    Order.where(state: 'IN_PREPARATION').update_all           state: 'preparation'
    Order.where(state: 'WAIT_DELIVERY').update_all            state: 'delivery'
    Order.where(state: 'ACHIEVED').update_all                 state: 'complete'
    Order.where(state: 'ORDER_CANCELED').update_all           state: 'canceled'
    Order.where(state: 'ERROR').update_all                    state: 'canceled'
  end

  def down
    Order.where(state: 'quotation').update_all        state: 'WAIT_ESTIMATE'
    Order.where(state: 'quote_validation').update_all state: 'WAIT_ESTIMATE_VALIDATION'
    Order.where(state: 'preparation').update_all      state: 'IN_PREPARATION'
    Order.where(state: 'delivery').update_all         state: 'WAIT_DELIVERY'
    Order.where(state: 'complete').update_all         state: 'ACHIEVED'
    Order.where(state: 'canceled').update_all         state: 'ORDER_CANCELED'
  end
end
