class UsersController < ApplicationController
  layout 'public'

  before_filter :authenticated?, :except => [:new, :create]
  before_filter :not_autenticated?, :only => [:new, :create]
  
  # GET /user
  # GET /user.xml
  def show
    @user = user_session.user

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  # GET /user/new
  # GET /user/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  # GET /user/edit
  def edit
    @user = user_session.user
  end

  # POST /user
  # POST /user.xml
  def create
    params[:user].delete_if do |key, value|
      ! %w(name email guild_id password password_confirmation dofusNicknames).include? key
    end
    
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = t('user.create_success')
        format.html { redirect_to root_path }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user
  # PUT /user.xml
  def update
    @user = user_session.user

    params[:user].delete_if do |key, value|
      ! %w(email guild_id password password_confirmation dofusNicknames).include? key
    end

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = t('user.update_success')
        format.html { redirect_to user_path }
        format.xml  { head :ok }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  private
  
  def authenticated?
    unless user_session.login?
      flash[:error] = t('userSession.youHaveToLog')
      redirect_to login_path
      false
    end
  end
  
  def not_autenticated?
    if user_session.login?
      flash[:error] = t('userSession.youHaveToUnLog')
      redirect_to root_path
      false
    end
  end
end
