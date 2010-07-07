class UsersController < ApplicationController
  before_filter :authentication, :except => [:new, :create, :activate, :passwordReset, :passwordResetForm]
  before_filter :noAuthentication, :only => [:new, :create, :activate, :passwordReset, :passwordResetForm]

  # GET /user
  # GET /user.xml
  def show
    respond_with(@user = user_session.user)
  end

  # GET /user/new
  # GET /user/new.xml
  def new
    respond_with(@user = User.new)
  end

  # GET /user/edit
  def edit
    respond_with(@user = user_session.user)
  end

  # POST /user
  # POST /user.xml
  def create
    params[:user].delete_if do |key, value|
      ! %w(name email guild_id password password_confirmation dofusNicknames).include? key
    end

    @user = User.new(params[:user])
    @user.save

    respond_with(@user)
  end

  # PUT /user
  # PUT /user.xml
  def update
    @user = user_session.user

    params[:user].delete_if do |key, value|
      ! %w(email guild_id password password_confirmation dofusNicknames).include? key
    end

    @user.update_attributes(params[:user])

    respond_with(@user, :location => user_path)
  end

  # GET /user/activate/:key
  # GET /user/activate/:key.xml
  def activate
    params[:key] ||= ''
    @user = User.find_by_activationKey(params[:key])

    @user.activate if @user

    respond_to do |format|
      if @user && @user.save
        flash[:notice] = 'Your account is now activated. Welcome '
        format.html { redirect_to login_path }
        format.xml  { head :ok }
      else
        flash[:alert] = 'This activation key doesn\'t match any account !'
        format.html { redirect_to root_path }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /user/passwordReset
  def passwordResetForm

  end

  # POST
  def passwordReset
    @user = User.find_by_email(params[:email])

    unless @user.blank?
      UserTools::passwordReset(@user)
      flash[:notice] = t('user.newPasswordSent')
    else
      flash[:alert] = t('user.emailNotMatch')
    end

    redirect_to root_path
  end

  private

  def noAuthentication
    if user_session.login?
      flash[:alert] = t('userSession.youHaveToUnLog')
      redirect_to root_path
      false
    end
  end
end
