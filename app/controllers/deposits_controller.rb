class DepositsController < ApplicationController
  before_filter :gathererOnly

  # GET /deposits
  # GET /deposits.xml
  def index
    respond_with(@deposits = current_user.deposits)
  end


  # GET /deposits/new
  # GET /deposits/new.xml
  def new
    respond_with(@deposit = Deposit.new)
  end

  # POST /deposits
  # POST /deposits.xml
  def create
    @deposit = Deposit.find_or_new({ :user_id => current_user.id, :asset_id => params[:deposit][:asset_id], :validated => false})
    @deposit.quantity_modifier = params[:deposit][:quantity_modifier]
    @deposit.save

    respond_with(@deposit, :location => user_deposits_path)
  end

  private

  def gathererOnly
    unless current_user.gatherer
      flash[:alert] = 'You can\'t view or make deposits if you\'re not gatherer'
      redirect_to root_path
      false
    end
  end
end
