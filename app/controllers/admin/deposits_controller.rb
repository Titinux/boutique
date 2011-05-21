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

class Admin::DepositsController < Admin::AdminController
  # GET /deposits
  # GET /deposits.xml
  def index
    @search = Deposit.search(params[:search])
    @deposits = @search.relation

    if params[:search].blank? || params[:search][:validated_is_true] != '1'
      @deposits = @deposits.validated(false)
    end

    @deposits = @deposits.includes(:user, :asset => :category).page(params[:page])

    respond_with(@deposits)
  end

  # GET /admin/deposits/new
  # GET /admin/deposits/new.xml
  def new
    respond_with(@deposit = Deposit.new)
  end

  # POST /admin/deposits
  # POST /admin/deposits.xml
  def create
    @deposit = Deposit.find_or_new({ :user_id => params[:deposit][:user_id], :asset_id => params[:deposit][:asset_id], :validated => params[:deposit][:validated]})
    @deposit.quantity_modifier = params[:deposit][:quantity_modifier]

    @deposit.save
    respond_with(@deposit, :location => admin_deposits_path)
  end

  # DELETE /admin/deposits/1
  # DELETE /admin/deposits/1.xml
  def destroy
    @deposit = Deposit.find(params[:id])
    @deposit.destroy

    respond_with(:admin, @deposit)
  end

  # PUT /admin/deposits/1/validate
  # PUT /admin/deposits/1/validate.xml
  def validate
    @deposit = Deposit.find(params[:id])
    @deposit.approve ? t('deposit.validation_success') : t('deposit.validation_failure')

    respond_with(:admin, @deposit)
  end
end
