class UserSessionController < ApplicationController
  layout 'public'

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
        flash[:notice] = t('userSession.successfullLogin', :username => @user_session.user.name )
        format.html do
          redirect_to(session[:urlRequested].blank? ? root_url : session[:urlRequested])
          session[:urlRequested] = nil
        end
      else
        flash[:alert] = 'Wrong login or password !'
        format.html { redirect_to(login_path) }
      end
    end
  end

  # DELETE /logout
  # DELETE /logout.xml
  def destroy
    user_session.logout
    flash[:notice] = t('userSession.successfullLogout')

    respond_to do |format|
      format.html { redirect_to(root_url) }
      format.xml  { head :ok }
    end
  end
end
