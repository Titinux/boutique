class OrdersController < ApplicationController
  layout 'public'
  
  # GET /admin/orders/1
  # GET /admin/orders/1.xml
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # PUT /validate_estimate/1
  # PUT /validate_estimate/1.xml
  def update
    @order = Order.find(params[:id])
    
    respond_to do |format|
      if @order.nextStep(user_session.user) && @order.save
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
