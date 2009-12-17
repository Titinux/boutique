class DepositsController < ApplicationController
  layout 'public'

  before_filter :authentication
  before_filter :gathererOnly

  # GET /deposits
  # GET /deposits.xml
  def index
    @validated_deposits = user_session.user.deposits.validated
    @waiting_deposits = user_session.user.deposits.validated(false)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /deposits/1
  # GET /deposits/1.xml
  def show
    @deposit = Deposit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /deposits/new
  # GET /deposits/new.xml
  def new
    @deposit = Deposit.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # POST /deposits
  # POST /deposits.xml
  def create
    @deposit = Deposit.find_or_new({ :user_id => user_session.user.id, :asset_id => params[:deposit][:asset_id], :validated => false})
    @deposit.quantity_modifier = params[:deposit][:quantity_modifier]

    respond_to do |format|
      if @deposit.save
        flash[:notice] = t('deposit.created')
        format.html { redirect_to deposits_path }
        format.xml  { render :xml => @deposit, :status => :created, :location => @deposit }
      else
        format.html { render :action => :new }
        format.xml  { render :xml => @deposit.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def gathererOnly
    unless user_session.user.gatherer
      flash[:error] = 'You can\'t view or make deposits if you\'re not gatherer'
      redirect_to root_path
      false
    end
  end
end
