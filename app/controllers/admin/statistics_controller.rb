class Admin::StatisticsController < Admin::AdminController
  # GET /admin/statistics
  # GET /admin/statistics.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @statlist }
    end
  end

  # GET /admin/statistics/:id
  # GET /admin/statistics/:id.xml
  def show
    redirect_to :action => 'index' and return unless Statistics.respond_to?("#{params[:id].downcase}Stats")

    @stats = Statistics.send("#{params[:id].downcase}Stats")

    respond_to do |format|
      format.html { render :template => "admin/statistics/#{params[:id]}" }
      format.xml  { render :xml => @stats }
    end
  end
end
