class Admin::DepositsController < Admin::AdminController

  # GET /deposits
  # GET /deposits.xml
  def index
    conditions = {}

    conditions[:user_id]  = params[:user_id]  unless params[:user_id].blank?
    conditions[:asset_id] = params[:asset_id] unless params[:asset_id].blank?
    conditions[:validated] = params[:approved] || false

    @deposits = Deposit.find(:all, :conditions => conditions)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /admin/deposits/new
  # GET /admin/deposits/new.xml
  def new
    @deposit = Deposit.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @deposit }
    end
  end

  # POST /admin/deposits
  # POST /admin/deposits.xml
  def create
    @deposit = Deposit.find_or_new({ :user_id => params[:deposit][:user_id], :asset_id => params[:deposit][:asset_id], :validated => params[:deposit][:validated]})
    @deposit.quantity_modifier = params[:deposit][:quantity_modifier]

    respond_to do |format|
      if @deposit.save
        flash[:notice] = t('deposit.created')
        format.html { redirect_to(admin_deposits_path) }
        format.xml  { render :xml => @deposit, :status => :created, :location => @deposit }
      else
        format.html { render :action => :new }
        format.xml  { render :xml => @deposits.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/deposits/1
  # DELETE /admin/deposits/1.xml
  def destroy
    @deposit = Deposit.find(params[:id])
    @deposit.destroy

    respond_to do |format|
      format.html { redirect_to admin_deposits_url }
      format.xml  { head :ok }
    end
  end

  # PUT /admin/deposits/1/validate
  # PUT /admin/deposits/1/validate.xml
  def validate
    @deposit = Deposit.find(params[:id])

    respond_to do |format|
      if @deposit.approve
        flash[:notice] = t('deposit.validation_success')
        format.html { redirect_to admin_deposits_path }
        format.xml  { head :ok }
      else
        flash[:error] = t('deposit.validation_failure')
        format.html { redirect_to admin_deposits_path }
        format.xml  { render :xml => @deposit.errors, :status => :unprocessable_entity }
      end
    end
  end
end
