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

module Admin
  class AdministratorsController < AdminController
    def index
      search_params = {"s" => "name asc"}.merge(params[:q] || {})

      @q               = Administrator.search(search_params)
      @administrators  = @q.result.page(params[:page])

      respond_with(@administrators)
    end

    def show
      respond_with(@administrator = Administrator.find(params[:id]))
    end

    def new
      respond_with(@administrator = Administrator.new)
    end

    def edit
      respond_with(@administrator = Administrator.find(params[:id]))
    end

    def create
      @administrator = Administrator.new(administrator_params)
      @administrator.save

      respond_with(:admin, @administrator)
    end

    def update
      @administrator = Administrator.find(params[:id])
      @administrator.update_attributes(administrator_params)

      respond_with(:admin, @administrator)
    end

    def destroy
      @administrator = Administrator.find(params[:id])
      @administrator.destroy

      respond_with(:admin, @administrator)
    end

    private

    def administrator_params
      if params[:administrator][:password].blank?
        params[:administrator].delete(:password)
        params[:administrator].delete(:password_confirmation)
      end

      params.require(:administrator).permit(:name, :email, :password, :password_confirmation, :blocked)
    end
  end
end
