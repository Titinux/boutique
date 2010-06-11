class StatisticsController < ApplicationController
  
  # GET /statistics
  # GET /statistics.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @statlist }
    end
  end

  # GET /statistics/:id
  # GET /statistics/:id.xml
  def show
    redirect_to :action => 'index' and return unless Statistics.respond_to?("#{params[:id].downcase}Stats")

    respond_to do |format|
      format.html { render :template => "statistics/#{params[:id]}" }
      #format.xml  { render :xml => @asset }
    end
  end
end
