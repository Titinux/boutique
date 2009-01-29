class UserSessionController < ApplicationController
  layout 'public'
  
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
        format.html { redirect_to(root_url) }
      end
    end
  end

  # DELETE /logout
  # DELETE /logout.xml
  def destroy
    user_session.logout
    
    respond_to do |format|
      format.html { redirect_to(root_url) }
      format.xml  { head :ok }
    end
  end
end
