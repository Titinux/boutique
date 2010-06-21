class Admin::AssetsController < Admin::AdminController
  # GET /admin/assets
  # GET /admin/assets.xml
  def index
    respond_with(@assets = Asset.all)
  end

  # GET /admin/assets/1
  # GET /admin/assets/1.xml
  def show
    respond_with(@asset = Asset.find(params[:id]))
  end

  # GET /admin/assets/new
  # GET /admin/assets/new.xml
  def new
    respond_with(@asset = Asset.new)
  end

  # GET /admin/assets/1/edit
  def edit
    respond_with(@asset = Asset.find(params[:id]))
  end

  # POST /admin/assets
  # POST /admin/assets.xml
  def create
    @asset = Asset.new(params[:asset])
    @asset.save

    respond_with(:admin, @asset)
  end

  # PUT /admin/assets/1
  # PUT /admin/assets/1.xml
  def update
    @asset = Asset.find(params[:id])
    @asset.update_attributes(params[:asset])

    respond_with(:admin, @asset)
  end

  # DELETE /admin/assets/1
  # DELETE /admin/assets/1.xml
  def destroy
    @asset = Asset.find(params[:id])
    @asset.destroy

    respond_with(:admin, @asset)
  end
end
