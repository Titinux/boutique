# Boutique is a saleroom website for Dofus resources, originally created
# for the merchant guild "Les Marchands d'Hyze"
# Copyright (C) 2011 - Jérémie Horhant (jeremie dot horhant at titinux dot net)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

class Admin::GuildsController < Admin::AdminController
  # GET /admin/guilds
  # GET /admin/guilds.xml
  def index
    @search = Guild.search(params[:search])
    @guilds = @search.page(params[:page]).order(:name)

    respond_with(@guilds)
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
    @guild = Guild.new(guild_params)
    @guild.save

    respond_with(:admin, @guild)
  end

  # PUT /admin/guilds/1
  # PUT /admin/guilds/1.xml
  def update
    @guild = Guild.find(params[:id])
    @guild.update_attributes(guild_params)

    respond_with(:admin, @guild)
  end

  # DELETE /admin/guilds/1
  # DELETE /admin/guilds/1.xml
  def destroy
    @guild = Guild.find(params[:id])
    @guild.destroy

    respond_with(:admin, @guild)
  end

  private

    def guild_params
      params.require(:guild).permit(:name, :pictureUri)
    end
end
