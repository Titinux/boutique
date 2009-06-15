class OrdersController < ApplicationController
  layout 'public'
  
  before_filter :order_owner_only
  
  # GET /order/1
  # GET /order/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # PUT /order_action/1
  # PUT /order_action/1.xml
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
    unless user_session.login?
      flash[:error] = t('userSession.youHaveToLog')
      redirect_to login_path
      return false
    end
    
    @order = Order.find(params[:id])
    
    unless @order.user.id == user_session.user.id
      flash[:error] = 'Access forbidden !'
      redirect_to user_path
      return false
    end
    
    true
  end
end
