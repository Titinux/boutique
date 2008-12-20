module Admin::OrdersHelper
  def add_order_line_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, 'order_lines', :partial => 'order_line', :locals => { :form_line => OrderLine.new }
    end
  end
end
