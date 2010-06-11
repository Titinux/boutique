class Admin::GuildsController < Admin::AdminController
  respond_to :html, :xml

  # GET /admin/guilds
  # GET /admin/guilds.xml
  def index
    respond_with(@guilds = Guild.all)
  end

  # GET /admin/guilds/1
  # GET /admin/guilds/1.xml
  def show
    respond_with(@guild = Guild.find(params[:id]))
  end

  # GET /admin/guilds/new
  # GET /admin/guilds/new.xml
  def new
    respond_with(@guild = Guild.new)
  end

  # GET /admin/guilds/1/edit
  def edit
    respond_with(@guild = Guild.find(params[:id]))
  end

  # POST /admin/guilds
  # POST /admin/guilds.xml
  def create
    @guild = Guild.new(params[:guild])
    flash[:notice] = 'Guild was successfully created.' if @guild.save

    respond_with(@guild, :location => [:admin, @guild])
  end

  # PUT /admin/guilds/1
  # PUT /admin/guilds/1.xml
  def update
    @guild = Guild.find(params[:id])
    flash[:notice] = 'Guild was successfully updated.' if @guild.update_attributes(params[:guild])

    respond_with(@guild, :location => [:admin, @guild])
  end

  # DELETE /admin/guilds/1
  # DELETE /admin/guilds/1.xml
  def destroy
    @guild = Guild.find(params[:id])
    @guild.destroy

    respond_with(@guild, :location => [:admin, @guild])
  end
end
