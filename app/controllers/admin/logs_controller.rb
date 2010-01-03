class Admin::LogsController < Admin::AdminController

  # GET /admin/guilds
  # GET /admin/guilds.xml
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

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @logs }
    end
  end

  # GET /admin/guilds/1
  # GET /admin/guilds/1.xml
  def show
    @log = Log.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @log }
    end
  end
end
