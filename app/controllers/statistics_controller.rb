class StatisticsController < ApplicationController
  layout 'public'
  
  # GET /statistics
  # GET /statistics.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @statlist }
    end
  end

  # GET /statistics/:stattype
  # GET /statistics/:stattype.xml
  def show
    redirect_to :action => 'index' and return unless Statistics.respond_to?("#{params[:stattype].downcase}Stats")
    
    respond_to do |format|
      format.html { render :template => "statistics/#{params[:stattype]}" }
      format.xml  { render :xml => @asset }
    end
  end
end
