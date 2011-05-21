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

class DepositsController < ApplicationController
  before_filter :gathererOnly

  # GET /deposits
  # GET /deposits.xml
  def index
    respond_with(@deposits = current_user.deposits)
  end


  # GET /deposits/new
  # GET /deposits/new.xml
  def new
    respond_with(@deposit = Deposit.new)
  end

  # POST /deposits
  # POST /deposits.xml
  def create
    @deposit = Deposit.find_or_new({ :user_id => current_user.id, :asset_id => params[:deposit][:asset_id], :validated => false})
    @deposit.quantity_modifier = params[:deposit][:quantity_modifier]
    @deposit.save

    respond_with(@deposit, :location => user_deposits_path)
  end

  private

  def gathererOnly
    unless current_user.gatherer
      flash[:alert] = 'You can\'t view or make deposits if you\'re not gatherer'
      redirect_to root_path
      false
    end
  end
end
