class CartsController < ApplicationController
  layout 'public'

  # GET /cart
  # GET /cart.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @assets }
    end
  end

  # GET /admin/assets/1
  # GET /admin/assets/1.xml
  def show
    @asset = Asset.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @asset }
    end
  end

  # GET /cart/new
  # GET /cart/new.xml
  def new
   redirect_to welcome_path unless params[:asset_id]

   @asset = Asset.find(params[:asset_id])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @asset }
    end
  end

  # GET /cart/1/edit
  def edit
    redirect_to welcome_path unless params[:id]

    @cart_line = cart_session.line(params[:id])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @asset }
    end
  end

  # POST /cart
  # POST /cart.xml
  def create
    @asset = Asset.find(params[:asset_id])

    respond_to do |format|
      if @asset
        cart_session.add_line(@asset.id, params[:quantity])
        flash[:notice] = t('cart.addCartSuccess')

        if params[:add_and_continue_shopping].blank?
          format.html { redirect_to(cart_index_path) }
          format.xml  { render :xml => @asset, :status => :created, :location => @asset }
        else
          format.html { redirect_to(categories_path(:cat => @asset.category.id)) }
          format.xml  { render :xml => @asset, :status => :created, :location => @asset }
        end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @asset.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cart/1
  # PUT /cart/1.xml
  def update
    @asset = Asset.find(params[:id])

    respond_to do |format|
      if @asset
        cart_session.edit_line(@asset.id, params[:quantity])
        flash[:notice] = t('cart.updateSuccess')
        format.html { redirect_to(cart_index_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @asset.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cart/1
  # DELETE /cart/1.xml
  def destroy
    @asset = Asset.find(params[:id])
    cart_session.drop_line(@asset.id)

    respond_to do |format|
      format.html { redirect_to(cart_index_url) }
      format.xml  { head :ok }
    end
  end

  # DELETE /cart/destroy_all
  # DELETE /cart/destroy_all.xml
  def destroy_all
    cart_session.empty_cart

    respond_to do |format|
      format.html { redirect_to(cart_index_url) }
      format.xml  { head :ok }
    end
  end

  # PUT /cart/to_order
  # PUT /cart/to_order
  def to_order
    respond_to do |format|
      begin
        cart_session.to_order(user_session)

        flash[:notice] = t('order.createSuccess')
        format.html { redirect_to(cart_index_path) }
        format.xml  { head :ok }
      rescue Exception => e
        flash.now[:error] = e.message
        format.html { render :action => "index" }
        format.xml  { render :xml => cart_session.errors, :status => :unprocessable_entity }
      end
    end
  end
end
