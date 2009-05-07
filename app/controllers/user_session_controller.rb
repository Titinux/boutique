class UserSessionController < ApplicationController
  layout 'public'
  
  before_filter :authenticated?, :only => [:show]
  
  # GET /user_session
  # GET /user_session.xml
  def show
    @user_session = user_session

    respond_to do |format|
      if @user_session.login?
        format.html # show.html.erb
        format.xml  { render :xml => @user_session.user }
      else
        format.html # show.html.erb
        format.xml  { render :xml => @user_session.user }
      end
    end
  end

  # GET /login
  # GET /login.xml
  def new
    @user_session = user_session

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_session }
    end
  end

  # POST /login
  # POST /login.xml
  def create
    @user_session = user_session
    @user_session.autenticate(params[:username], params[:password])

    respond_to do |format|
      if @user_session.login?
        flash[:notice] = 'Successfully logged in.'
        format.html { redirect_to(root_url) }
      else
        flash[:error] = 'Wrong login or password !'
        format.html { redirect_to(login_path) }
      end
    end
  end

  # DELETE /logout
  # DELETE /logout.xml
  def destroy
    user_session.logout
    flash[:notice] = 'Thank you for visiting our shop, we hope to see you soon.'
    
    respond_to do |format|
      format.html { redirect_to(root_url) }
      format.xml  { head :ok }
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
end
