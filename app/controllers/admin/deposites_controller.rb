class Admin::DepositesController < Admin::AdminController
  
  # GET /deposites
  # GET /deposites.xml
  def index
    @waiting_deposites = Deposite.validated?(false)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end
  
  # PUT /admin/deposites/1
  # PUT /admin/deposites/1.xml
  def update
    @deposite = Deposite.find(params[:id])
    @deposite.validated = params[:validate]

    respond_to do |format|
      if @deposite.save
        flash[:notice] = 'Deposite was successfully updated.'
        format.html { redirect_to admin_deposites_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @deposite.errors, :status => :unprocessable_entity }
      end
    end
  end
end
