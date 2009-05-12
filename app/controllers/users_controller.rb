class UsersController < ApplicationController
  layout 'public'

  before_filter :authenticated?
  
  # GET /user
  # GET /user.xml
  def show
    @user = user_session.user

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  # GET /user/edit
  def edit
    @user = user_session.user
  end

  # PUT /user
  # PUT /user.xml
  def update
    @user = user_session.user

    params[:user].delete_if do |key, value|
      ! %w(email guild_id password password_confirmation).include? key
    end

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'Your profile was successfully updated.'
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
end
