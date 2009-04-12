class Admin::GuildsController < Admin::AdminController
  
  # GET /admin/guilds
  # GET /admin/guilds.xml
  def index
    @guilds = Guild.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @guilds }
    end
  end

  # GET /admin/guilds/1
  # GET /admin/guilds/1.xml
  def show
    @guild = Guild.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @guild }
    end
  end

  # GET /admin/guilds/new
  # GET /admin/guilds/new.xml
  def new
    @guild = Guild.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @guild }
    end
  end

  # GET /admin/guilds/1/edit
  def edit
    @guild = Guild.find(params[:id])
  end

  # POST /admin/guilds
  # POST /admin/guilds.xml
  def create
    @guild = Guild.new(params[:guild])

    respond_to do |format|
      if @guild.save
        flash[:notice] = 'Guild was successfully created.'
        format.html { redirect_to([:admin, @guild]) }
        format.xml  { render :xml => @guild, :status => :created, :location => @guild }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @guild.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/guilds/1
  # PUT /admin/guilds/1.xml
  def update
    @guild = Guild.find(params[:id])

    respond_to do |format|
      if @guild.update_attributes(params[:guild])
        flash[:notice] = 'Guild was successfully updated.'
        format.html { redirect_to([:admin, @guild]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @guild.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/guilds/1
  # DELETE /admin/guilds/1.xml
  def destroy
    @guild = Guild.find(params[:id])
    @guild.destroy

    respond_to do |format|
      format.html { redirect_to(admin_guilds_url) }
      format.xml  { head :ok }
    end
  end
end
