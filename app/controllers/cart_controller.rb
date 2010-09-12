class CartController < ApplicationController
  respond_to :html, :xml

  # GET /cart
  # GET /cart.xml
  def show
    respond_with(@cart = current_user.cart)
  end

  def edit
    @cart = current_user.cart

    respond_with(@cart, :location => cart_path)
  end

  def update
    @cart = current_user.cart
    @cart.attributes = params[:cart]

    if params[:addline].blank?
      @cart.save
      respond_with(@cart, :location => cart_path)
    else
      @cart.lines.build
      render :edit
    end
  end

  # DELETE /cart/
  # DELETE /cart.xml
  def destroy
    @cart = current_user.cart
    @cart.destroy

    respond_with(@cart, :location => cart_path)
  end

  # GET /cart/save
  # GET /cart/save.xml
  def save
    @cart = current_user.carts.build

    current_user.cart.lines.each do |line|
      @cart.lines.build(line.attributes)
    end
  end

  # PUT /cart/to_order
  # PUT /cart/to_order
  def to_order
    @cart = current_user.cart

    if @cart.to_order
      flash[:notice] = t('flash.carts.to_order.notice')
      @cart.lines.delete_all
      redirect_to user_orders_path
    else
      flash[:alert] = t('flash.carts.to_order.alert')
      render 'show'
    end
  end
end
