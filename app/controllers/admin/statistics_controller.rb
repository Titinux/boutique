class Admin::StatisticsController < Admin::AdminController
  # GET /admin/statistics
  # GET /admin/statistics.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @statlist }
    end
  end

  # GET /admin/statistics/:stattype
  # GET /admin/statistics/:stattype.xml
  def show
    redirect_to :action => 'index' and return unless Statistics.respond_to?("#{params[:stattype].downcase}Stats")

    @stats = Statistics.send("#{params[:stattype].downcase}Stats")

    respond_to do |format|
      format.html { render :template => "admin/statistics/#{params[:stattype]}" }
      format.xml  { render :xml => @stats }
    end
  end
end
