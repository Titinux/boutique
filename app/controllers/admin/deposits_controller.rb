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
        flash[:notice] = 'Deposit was successfully validated.'
        format.html { redirect_to admin_deposits_path }
        format.xml  { head :ok }
      else
        format.html { redirect_to admin_deposits_path }
        format.xml  { render :xml => @deposit.errors, :status => :unprocessable_entity }
      end
    end
  end
end
