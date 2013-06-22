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

class Admin::DepositsController < Admin::AdminController
  def index
    search_params = {"s" => "asset_name asc", "validated_false" => '1'}.merge(params[:q] || {})

    @q        = Deposit.includes(:user, asset: :category).search(search_params)
    @deposits = @q.result.page(params[:page])

    respond_with(@deposits)
  end

  def new
    respond_with(@deposit = Deposit.new)
  end

  def create
    validated = deposit_params[:validated] == '1'

    @deposit = Deposit.find_or_new({ user_id: deposit_params[:user_id], asset_id: deposit_params[:asset_id], validated: validated})
    @deposit.quantity_modifier = deposit_params[:quantity_modifier]
    @deposit.save

    respond_with(@deposit, location: admin_deposits_path)
  end

  def destroy
    @deposit = Deposit.find(params[:id])

    if @deposit.destroy
      flash[:notice] = t('deposit.destroy_success', { user: @deposit.user.name, asset: @deposit.asset.name, quantity: @deposit.quantity })
    end

    respond_with(:admin, @deposit)
  end

  def validate
    @deposit = Deposit.find(params[:id])
    if @deposit.approve
      flash[:notice] = t('deposit.validation_success', { user: @deposit.user.name, asset: @deposit.asset.name, quantity: @deposit.quantity })
    else
      flash[:error] = t('deposit.validation_failure', { user: @deposit.user.name, asset: @deposit.asset.name, quantity: @deposit.quantity })
    end

    respond_with(:admin, @deposit)
  end

  private

    def deposit_params
      params.require(:deposit).permit(:user_id, :asset_id, :quantity_modifier, :validated)
    end
end
