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

class Admin::CategoriesController < Admin::AdminController
  def index
    search_params = {"s" => "name asc"}.merge(params[:q] || {})

    @q          = Category.search(search_params)
    @categories = @q.result.page(params[:page])

    respond_with(@categories)
  end

  def show
    respond_with(@category = Category.find(params[:id]))
  end

  def new
    respond_with(@category = Category.new)
  end

  def edit
    respond_with(@category = Category.find(params[:id]))
  end

  def create
    @category = Category.new(category_params)
    @category.save

    respond_with(:admin, @category)
  end

  def update
    @category = Category.find(params[:id])
    @category.update_attributes(category_params)

    respond_with(:admin, @category)
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_with(:admin, @category)
  end

  private

    def category_params
      params.require(:category).permit(:name, :parent_id, :pictureUri)
    end
end
