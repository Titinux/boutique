class Admin::CategoriesController < Admin::AdminController
  respond_to :html, :xml

  # GET /admin/categories
  # GET /admin/categories.xml
  def index
    respond_with(@categories = Category.all)
  end

  # GET /admin/categories/1
  # GET /admin/categories/1.xml
  def show
    respond_with(@category = Category.find(params[:id]))
  end

  # GET /admin/categories/new
  # GET /admin/categories/new.xml
  def new
    respond_with(@category = Category.new)
  end

  # GET /admin/categories/1/edit
  def edit
    respond_with(@category = Category.find(params[:id]))
  end

  # POST /admin/categories
  # POST /admin/categories.xml
  def create
    @category = Category.new(params[:category])
    flash[:notice] = 'Category was successfully created.' if @category.save

    respond_with(@category, :location => [:admin, @category])
end

  # PUT /admin/categories/1
  # PUT /admin/categories/1.xml
  def update
    @category = Category.find(params[:id])
    flash[:notice] = 'Category was successfully updated.' if @category.save

    respond_with(@category, :location => [:admin, @category])
  end

  # DELETE /admin/categories/1
  # DELETE /admin/categories/1.xml
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_with(@category, :location => [:admin, @category])
  end
end
