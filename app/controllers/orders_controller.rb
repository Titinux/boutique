class OrdersController < ApplicationController
  layout 'public'
  
  # GET /order/1
  # GET /order/1.xml
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # PUT /order_action/1
  # PUT /order_action/1.xml
  def update
    @order = Order.find(params[:id])
    
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
end
