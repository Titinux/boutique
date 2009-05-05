class Statistics
  
  def self.list(admin = false)
    if(admin)
    {
    :ASSETS => I18n.t('statistics.assetsStatistics'),
    :ORDERS => I18n.t('statistics.ordersStatistics'),
    :STOCK  => I18n.t('statistics.stockStatistics')
    } 
    else
    {
    #:ASSETS => 'Assets statistics',
    #:ORDERS => 'Orders statistics',
    :STOCK  => I18n.t('statistics.stockStatistics')
    }
    end
  end
  
  def self.stockStats
    assets = Asset.find(:all, :include => [:deposites, :order_lines], :order => :name)

    assets.each do |asset|
      def asset.stock
        @stock ||= self.deposites.validated.sum(:quantity)
      end
      
      def asset.orderQuantity
        @orderQuantity ||= self.order_lines.inject(0) do |sum, order_line|
          order_line.order.blank? || ['ACHIEVED', 'ORDER_CANCELED', 'ERROR'].include?(order_line.order.state) ? sum : (sum + order_line.quantity)
        end      
      end
    end
  end
end