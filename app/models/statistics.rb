class Statistics

  def self.stockStats
    assets = Asset.find(:all, :include => [:deposits, :order_lines], :order => :name)

    assets.each do |asset|
      def asset.stock
        @stock ||= self.deposits.validated.sum(:quantity)
      end

      def asset.orderQuantity
        @orderQuantity ||= self.order_lines.inject(0) do |sum, order_line|
          order_line.order.blank? || ['IN_PREPARATION', 'WAIT_DELIVERY'].include?(order_line.order.state) ? (sum + order_line.quantity) : sum
        end
      end
    end
  end

  def self.pigmoneyboxStats
    out = {}

    users = User.all(:order => 'pigMoneyBox DESC')

    out[:sum]     = users.sum(&:pigMoneyBox)
    out[:richests] = users.slice(0, 3)

    out
  end
end
