class Admin::UsersController < Admin::AdminController
  respond_to :html, :xml

  # GET /admin/users
  # GET /admin/users.xml
  def index
    @letter = params[:letter] || session[:admin_user_letter] || 'A'
    session[:admin_user_letter] = @letter

    if @letter == '*'
      @users = User.where("NOT (`users`.`name` REGEXP '^[[:alpha:]]')")
    else
      @users = User.where("`users`.`name` LIKE '#{@letter}%'")
    end

    respond_with(@users)
  end

  # GET /admin/users/1
  # GET /admin/users/1.xml
  def show
    respond_with(@user = User.find(params[:id]))
  end

  # GET /admin/users/new
  # GET /admin/users/new.xml
  def new
    respond_with(@user = User.new)
  end

  # GET /edit/users/1/edit
  def edit
    respond_with(@user = User.find(params[:id]))
  end

  # POST /admin/users
  # POST /admin/users.xml
  def create
    @user = User.new(params[:user])
    flash[:notice] = 'User was successfully created.' if @user.save

    respond_with(@user, :location => [:admin, @user])
  end

  # PUT /admin/users/1
  # PUT /admin/users/1.xml
  def update
    @user = User.find(params[:id])
    flash[:notice] = 'User was successfully updated.' if @user.update_attributes(params[:user])

    respond_with(@user, :location => [:admin, @user])
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_with(@user, :location => [:admin, @user])
  end
end
