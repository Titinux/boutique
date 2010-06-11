class Admin::OrdersController < Admin::AdminController
  respond_to :html, :xml

  # GET /admin/orders
  # GET /admin/orders.xml
  def index
    @orders = Order.includes(:user, :lines)

    @orders = @orders.where(:id, params[:id]) unless params[:id].blank?
    @orders = @orders.where(:user_id, params[:user_id]) unless params[:user_id].blank?
    @orders = @orders.where(:state, params[:state]) unless params[:state].blank?

    if params[:id].blank? && params[:user_id].blank? && params[:state].blank?
      @orders = @orders.ongoing
    end

    respond_with(@orders)
  end

  # GET /admin/orders/1
  # GET /admin/orders/1.xml
  def show
    respond_with(@order = Order.find(params[:id]))
  end

  # GET /admin/orders/new
  # GET /admin/orders/new.xml
  def new
    @order = Order.new
    @order.lines.build

    respond_with(@order)
  end

  # GET /admin/orders/1/edit
  def edit
    respond_with(@order = Order.find(params[:id]))
    #@estimateRestriction = params[:estimate]
  end

  # POST /admin/orders
  # POST /admin/orders.xml
  def create
    @order = Order.new(params[:order])
    flash[:notice] = 'Order was successfully created.' if @order.save

    respond_with(@order, :location => [:admin, @order])
  end

  # PUT /admin/orders/1
  # PUT /admin/orders/1.xml
  def update
    @order = Order.find(params[:id])
    flash[:notice] = 'Order was successfully updated.' if @order.update_attributes(params[:order])

    respond_with(@order, :location => [:admin, @order])
  end

  # DELETE /admin/orders/1
  # DELETE /admin/orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_with(@order, :location => [:admin, @order])
  end
end
