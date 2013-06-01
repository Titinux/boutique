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

class DepositsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :gathererOnly

  def index
    respond_with(@deposits = current_user.deposits.joins(:asset).order(Asset.arel_table[:name]))
  end

  def new
    respond_with(@deposit = Deposit.new)
  end

  def create
    deposits = current_user.deposits

    @deposit = deposits.where(deposit_params.except(:quantity_modifier)).first || deposits.build(deposit_params)
    @deposit.quantity_modifier = deposit_params[:quantity_modifier] if @deposit.persisted?
    @deposit.save

    respond_with(@deposit, :location => user_deposits_path)
  end

  private

  def deposit_params
    safe_params = params.require(:deposit).permit(:asset_id, :quantity_modifier)
    safe_params.merge(validated: false)
  end

  def gathererOnly
    unless current_user.gatherer
      flash[:alert] = 'You can\'t view or make deposits if you\'re not gatherer'
      redirect_to root_path
      false
    end
  end
end
