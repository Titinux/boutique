class DepositesController < ApplicationController
  # GET /deposites
  # GET /deposites.xml
  def index
    @deposites = Deposite.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @deposites }
    end
  end

  # GET /deposites/1
  # GET /deposites/1.xml
  def show
    @deposite = Deposite.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @deposite }
    end
  end

  # GET /deposites/new
  # GET /deposites/new.xml
  def new
    @deposite = Deposite.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @deposite }
    end
  end

  # GET /deposites/1/edit
  def edit
    @deposite = Deposite.find(params[:id])
  end

  # POST /deposites
  # POST /deposites.xml
  def create
    @deposite = Deposite.new(params[:deposite])

    respond_to do |format|
      if @deposite.save
        flash[:notice] = 'Deposite was successfully created.'
        format.html { redirect_to(@deposite) }
        format.xml  { render :xml => @deposite, :status => :created, :location => @deposite }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @deposite.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /deposites/1
  # PUT /deposites/1.xml
  def update
    @deposite = Deposite.find(params[:id])

    respond_to do |format|
      if @deposite.update_attributes(params[:deposite])
        flash[:notice] = 'Deposite was successfully updated.'
        format.html { redirect_to(@deposite) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @deposite.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /deposites/1
  # DELETE /deposites/1.xml
  def destroy
    @deposite = Deposite.find(params[:id])
    @deposite.destroy

    respond_to do |format|
      format.html { redirect_to(deposites_url) }
      format.xml  { head :ok }
    end
  end
end
