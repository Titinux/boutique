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
      if @order.modifyState(params[:op]) && @order.save
        flash[:notice] = 'Estimate was successfully accepted.'
        format.html { render :action => 'show' }
        format.xml  { head :ok }
      else
        format.html { render :action => "show" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end
end
