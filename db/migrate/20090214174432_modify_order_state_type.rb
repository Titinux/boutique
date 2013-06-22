class ModifyOrderStateType < ActiveRecord::Migration
  def self.up
    change_column(:orders, :state, :string, limit: 30, null: false)

    Order.reset_column_information

    say_with_time('Updating orders states...') do
      Order.find(:all).each do |order|
        case order.state
          when '0'
            order.state = 'WAIT_ESTIMATE'

          when '1'
            order.state = 'WAIT_ESTIMATE_VALIDATION'

          when '2'
            order.state = 'IN_PREPARATION'

          when '3'
            order.state = 'WAIT_DELIVERY'

          when '4'
            order.state = 'ACHIEVED'
        end

        order.save
      end
    end
  end

  def self.down
    say_with_time('Updating orders states...') do
      Order.find(:all).each do |order|
        case order.state
          when 'WAIT_ESTIMATE'
            order.state = 0

          when 'WAIT_ESTIMATE_VALIDATION'
            order.state = 1

          when 'IN_PREPARATION'
            order.state = 3

          when 'WAIT_DELIVERY'
            order.state = 4

          when 'ACHIEVED'
            order.state = 5
        end

        order.save
      end
    end

    change_column(:orders, :state, :integer, null: false)
  end
end
