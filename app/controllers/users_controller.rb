class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:new, :create]

  # GET /user
  # GET /user.xml
  def show
    respond_with(@user = current_user)
  end

  # GET /user/new
  def new
    respond_with(@user = User.new)
  end

  # GET /user/edit
  def edit
    respond_with(@user = current_user)
  end

  # POST /user
  # POST/user.xml
  def create
    @user = User.new(params[:user])
    @user.save

    respond_with(@user)
  end

  # PUT /user
  # PUT /user.xml
  def update
    @user = current_user
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?

    @user.update_attributes(params[:user])

    respond_with(@user, :location => user_path)
  end
end
