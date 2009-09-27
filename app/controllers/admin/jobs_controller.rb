class Admin::JobsController < Admin::AdminController
  
  # GET /admin/jobs
  # GET /admin/jobs.xml
  def index
    @jobs = Job.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @jobs }
    end
  end
end