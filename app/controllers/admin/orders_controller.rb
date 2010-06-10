class Admin::OrdersController < Admin::AdminController

  # GET /admin/orders
  # GET /admin/orders.xml
  def index
    @orders = Order.includes(:user, :lines)

    @orders = @orders.where(:id => params[:id]) unless params[:id].blank?
    @orders = @orders.where(:user_id => params[:user_id]) unless params[:user_id].blank?
    @orders = @orders.where(:state => params[:state]) unless params[:state].blank?

    if params[:id].blank? && params[:user_id].blank? && params[:state].blank?
      @orders = @orders.ongoing
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /admin/orders/1
  # GET /admin/orders/1.xml
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /admin/orders/new
  # GET /admin/orders/new.xml
  def new
    @order = Order.new
    @order.lines.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /admin/orders/1/edit
  def edit
    @order = Order.find(params[:id])
    #@estimateRestriction = params[:estimate]
  end

  # POST /admin/orders
  # POST /admin/orders.xml
  def create
    @order = Order.new(params[:order])

    respond_to do |format|
      if @order.save
        flash[:notice] = 'Order was successfully created.'
        format.html { redirect_to([:admin, @order]) }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/orders/1
  # PUT /admin/orders/1.xml
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        flash[:notice] = 'Order was successfully updated.'
        format.html { redirect_to(([:admin, @order])) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/orders/1
  # DELETE /admin/orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(admin_orders_url) }
      format.xml  { head :ok }
    end
  end
end
