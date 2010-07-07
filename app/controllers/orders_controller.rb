class OrdersController < ApplicationController
  respond_to :html, :xml

  rescue_from ActiveRecord::RecordNotFound do
    flash[:alert] = 'Order not found !'
    redirect_to user_path
  end

  before_filter :authentication

  def index
    respond_with(@orders = user_session.user.orders)
  end

  # GET /user/order/1
  # GET /user/order/1.xml
  def show
    respond_with(@order = user_session.user.orders.find(params[:id]))
  end

  # PUT /user/order/1
  # PUT /user/order/1.xml
  def update
    @order = user_session.user.orders.find(params[:id])

    if @order.modifyState(params[:op])
      flash[:notice] = @order.message
    else
      flash[:alert] = @order.message
    end

    respond_with(@order, :location => user_path)
  end
end
