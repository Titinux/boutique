class Admin::LogsController < Admin::AdminController
  respond_to :html, :xml

  # GET /admin/logs
  # GET /admin/logs.xml
  def index
    conditions = []

    conditions << "`id` = '#{params[:id]}'"                 unless params[:id].blank?
    conditions << "`user` = '#{params[:user]}'"             unless params[:user].blank?
    conditions << "`action` = '#{params[:logAction]}'"      unless params[:logAction].blank?
    conditions << "`objectType` = '#{params[:objectType]}'" unless params[:objectType].blank?
    conditions << "`objectId` = '#{params[:objectId]}'"     unless params[:objectId].blank?
    conditions << "`created_at` >= '#{DateTime.parse(params[:startDate])}'" unless params[:startDate].blank?
    conditions << "`created_at` <= '#{DateTime.parse(params[:endDate])}'"   unless params[:endDate].blank?

    @logs = Log.paginate :page => params[:page], :per_page => 50, :conditions => conditions.join(' AND ')

    respond_with(@logs)
  end

  # GET /admin/logs/1
  # GET /admin/logs/1.xml
  def show
    respond_with(@log = Log.find(params[:id]))
  end
end
