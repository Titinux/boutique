class Statistics
  
  def self.list(admin = false)
    if(admin)
    {
    :ASSETS => 'Assets statistics',
    :ORDERS => 'Orders statistics',
    :STOCK  => 'Stock statistics'
    } 
    else
    {
    #:ASSETS => 'Assets statistics',
    #:ORDERS => 'Orders statistics',
    :STOCK  => 'Stock statistics'
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