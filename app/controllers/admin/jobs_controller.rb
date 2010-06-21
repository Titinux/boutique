class Admin::JobsController < Admin::AdminController
  # GET /admin/jobs
  # GET /admin/jobs.xml
  def index
    respond_with(@jobs = Job.all)
  end
end
