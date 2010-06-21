class Admin::GuildsController < Admin::AdminController
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
    @guild.save

    respond_with(:admin, @guild)
  end

  # PUT /admin/guilds/1
  # PUT /admin/guilds/1.xml
  def update
    @guild = Guild.find(params[:id])
    @guild.update_attributes(params[:guild])

    respond_with(:admin, @guild)
  end

  # DELETE /admin/guilds/1
  # DELETE /admin/guilds/1.xml
  def destroy
    @guild = Guild.find(params[:id])
    @guild.destroy

    respond_with(:admin, @guild)
  end
end
