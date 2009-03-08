class StatisticsController < ApplicationController
  layout 'public'
  
  # GET /statistics
  # GET /statistics.xml
  def index
    @statlist = Statistics.list
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @statlist }
    end
  end

  # GET /statistics/:stattype
  # GET /statistics/:stattype.xml
  def show
    redirect_to :action => 'index' and return unless Statistics.list.has_key?(params[:stattype].upcase.to_sym)
    
    respond_to do |format|
      format.html { render :template => "statistics/#{params[:stattype]}" }
      format.xml  { render :xml => @asset }
    end
  end
end
