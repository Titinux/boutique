class Admin::AdministratorsController < Admin::AdminController
  # GET /admin/administrators
  # GET /admin/administrators.xml
  def index
    @letter = params[:letter] || session[:admin_administrator_letter] || 'A'
    session[:admin_administrator_letter] = @letter

    if @letter == '*'
      @administrators = Administrator.where("NOT (`administrators`.`name` REGEXP '^[[:alpha:]]')")
    else
      @administrators = Administrator.where("`administrators`.`name` LIKE '#{@letter}%'")
    end

    respond_with(@administrators)
  end

  # GET /admin/administrators/1
  # GET /admin/administrators/1.xml
  def show
    respond_with(@administrator = Administrator.find(params[:id]))
  end

  # GET /admin/administrators/new
  # GET /admin/administrators/new.xml
  def new
    respond_with(@administrator = Administrator.new)
  end

  # GET /edit/administrators/1/edit
  def edit
    respond_with(@administrator = Administrator.find(params[:id]))
  end

  # POST /admin/administrators
  # POST /admin/administrators.xml
  def create
    @administrator = Administrator.new(params[:administrator])
    @administrator.save

    respond_with(:admin, @administrator)
  end

  # PUT /admin/administrators/1
  # PUT /admin/administrators/1.xml
  def update
    @administrator = Administrator.find(params[:id])
    params[:administrator].delete(:password) if params[:administrator][:password].blank?
    params[:administrator].delete(:password_confirmation) if params[:administrator][:password_confirmation].blank?

    @administrator.update_attributes(params[:administrator])

    respond_with(:admin, @administrator)
  end

  # DELETE /admin/administrators/1
  # DELETE /admin/administrators/1.xml
  def destroy
    @administrator = Administrator.find(params[:id])
    @administrator.destroy

    respond_with(:admin, @administrator)
  end
end
