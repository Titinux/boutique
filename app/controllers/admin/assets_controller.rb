# Boutique is a saleroom website for Dofus resources, originally created
# for the merchant guild "Les Marchands d'Hyze"
# Copyright (C) 2013 - Jérémie Horhant (jeremie dot horhant at titinux dot net)
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

class Admin::AssetsController < Admin::AdminController
  def index
    search_params = {"s" => "name asc"}.merge(params[:q] || {})

    @q      = Asset.includes(:category).search(search_params)
    @assets = @q.result.page(params[:page])

    respond_with(@assets)
  end

  def show
    respond_with(@asset = Asset.find(params[:id]))
  end

  def new
    respond_with(@asset = Asset.new)
  end

  def edit
    respond_with(@asset = Asset.find(params[:id]))
  end

  def create
    @asset = Asset.new(asset_params)
    @asset.save

    respond_with(:admin, @asset)
  end

  def update
    @asset = Asset.find(params[:id])
    @asset.update_attributes(asset_params)

    respond_with(:admin, @asset)
  end

  def destroy
    @asset = Asset.find(params[:id])
    @asset.destroy

    respond_with(:admin, @asset)
  end

  private

  def asset_params
    params.require(:asset).permit(:name, :category_id, :pictureUri)
  end
end
