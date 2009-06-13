class DepositesController < ApplicationController
  layout 'public'
  
  before_filter :authenticated?
  before_filter :gatherer?
  
  # GET /deposites
  # GET /deposites.xml
  def index
    @validated_deposites = user_session.user.deposites.validated
    @waiting_deposites = user_session.user.deposites.validated(false)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /deposites/1
  # GET /deposites/1.xml
  def show
    @deposite = Deposite.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /deposites/new
  # GET /deposites/new.xml
  def new
    @deposite = Deposite.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # POST /deposites
  # POST /deposites.xml
  def create
    @deposite = Deposite.new(params[:deposite])
    @deposite.user = user_session.user

    respond_to do |format|
      if Deposite.compact { @deposite.save }
        flash[:notice] = t('deposite.created')
        format.html { redirect_to deposites_path }
        format.xml  { render :xml => @deposite, :status => :created, :location => @deposite }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @deposite.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  private
  
  def authenticated?
    unless user_session.login?
      flash[:error] = 'You have to be logged in to view user informations'
      redirect_to login_path
      false
    end
  end
  
  def gatherer?
    unless user_session.user.gatherer
      flash[:error] = 'You can\'t view or make deposites if you\'re not gatherer'
      redirect_to root_path
      false
    end
  end
end
