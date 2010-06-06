class OrdersController < ApplicationController
  layout 'public'

  before_filter :authentication
  before_filter :order_owner_only, :except => :index


  def index
    @orders = user_session.user.orders

    respond_to do |format|
      format.html
      format.xml { render :xml => @orders}
    end
  end

  # GET /user/order/1
  # GET /user/order/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # PUT /user/order/1
  # PUT /user/order/1.xml
  def update
    respond_to do |format|
      if @order.modifyState(params[:op])
        flash[:notice] = @order.message
        format.html { redirect_to user_path }
        format.xml  { head :ok }
      else
        flash[:error] = @order.message
        format.html { redirect_to user_path }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def order_owner_only
    @order = Order.find(params[:id])

    if @order.blank? or @order.user.id != user_session.user.id
      flash[:error] = 'Access forbidden !'
      redirect_to user_path
      return false
    end

    true
  end
end
