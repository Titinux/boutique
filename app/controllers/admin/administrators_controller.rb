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

class Admin::AdministratorsController < Admin::AdminController
  # GET /admin/administrators
  # GET /admin/administrators.xml
  def index
    @search          = Administrator.search(params[:search])
    @administrators  = @search.page(params[:page]).order(:name)

    respond_with(@administrators)
  end

  # GET /admin/administrators/1
  # GET /admin/administrators/1.xml
  def show
    respond_with(@administrator = Administrator.find(params[:id]))
  end

  # GET /admin/administrators/new
  # GET /admin/administrators/new.xml
  def new
    respond_with(@administrator = Administrator.new)
  end

  # GET /edit/administrators/1/edit
  def edit
    respond_with(@administrator = Administrator.find(params[:id]))
  end

  # POST /admin/administrators
  # POST /admin/administrators.xml
  def create
    @administrator = Administrator.new(params[:administrator])
    @administrator.save

    respond_with(:admin, @administrator)
  end

  # PUT /admin/administrators/1
  # PUT /admin/administrators/1.xml
  def update
    @administrator = Administrator.find(params[:id])
    params[:administrator].delete(:password) if params[:administrator][:password].blank?
    params[:administrator].delete(:password_confirmation) if params[:administrator][:password_confirmation].blank?

    @administrator.update_attributes(params[:administrator])

    respond_with(:admin, @administrator)
  end

  # DELETE /admin/administrators/1
  # DELETE /admin/administrators/1.xml
  def destroy
    @administrator = Administrator.find(params[:id])
    @administrator.destroy

    respond_with(:admin, @administrator)
  end
end
