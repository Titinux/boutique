class Admin::LogsController < Admin::AdminController
  # GET /admin/logs
  # GET /admin/logs.xml
  def index
    @search = Log.search(params[:search])
    @logs = @search.page(params[:page]).order('created_at DESC')

    respond_with(@logs)
  end

  # GET /admin/logs/1
  # GET /admin/logs/1.xml
  def show
    respond_with(@log = Log.find(params[:id]))
  end
end
