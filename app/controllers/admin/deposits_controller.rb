class Admin::DepositsController < Admin::AdminController
  # GET /deposits
  # GET /deposits.xml
  def index
    @deposits = Deposit.scoped
    @deposits = @deposits.where(:user_id =>  params[:user_id])  unless params[:user_id].blank?
    @deposits = @deposits.where(:asset_id => params[:asset_id]) unless params[:asset_id].blank?
    @deposits = @deposits.where(:validated => params[:approved] || false)

    respond_with(@deposits)
  end

  # GET /admin/deposits/new
  # GET /admin/deposits/new.xml
  def new
    respond_with(@deposit = Deposit.new)
  end

  # POST /admin/deposits
  # POST /admin/deposits.xml
  def create
    @deposit = Deposit.find_or_new({ :user_id => params[:deposit][:user_id], :asset_id => params[:deposit][:asset_id], :validated => params[:deposit][:validated]})
    @deposit.quantity_modifier = params[:deposit][:quantity_modifier]

    @deposit.save
    respond_with(@deposit, :location => admin_deposits_path)
  end

  # DELETE /admin/deposits/1
  # DELETE /admin/deposits/1.xml
  def destroy
    @deposit = Deposit.find(params[:id])
    @deposit.destroy

    respond_with(:admin, @deposit)
  end

  # PUT /admin/deposits/1/validate
  # PUT /admin/deposits/1/validate.xml
  def validate
    @deposit = Deposit.find(params[:id])
    @deposit.approve ? t('deposit.validation_success') : t('deposit.validation_failure')

    respond_with(:admin, @deposit)
  end
end
