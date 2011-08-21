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

class Admin::UsersController < Admin::AdminController
  def index
    @search = User.search(params[:search])
    @users = @search.includes(:guild).page(params[:page]).order(User.arel_table[:name])

    respond_with(@users)
  end

  def show
    @user = User.find(params[:id])
    @search_deposits = @user.deposits.validated.search(params[:search])
    @deposits = @search_deposits.includes(:user, :asset => :category).page(params[:page])

    respond_with(@user)
  end

  def new
    respond_with(@user = User.new)
  end

  def edit
    respond_with(@user = User.find(params[:id]))
  end

  def create
    @user = User.new(params[:user])
    @user.save

    respond_with(:admin, @user)
  end

  def update
    @user = User.find(params[:id])
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?

    @user.confirm! if params[:user][:confirmed] == '1'
    @user.update_attributes(params[:user].except(:confirmed))

    respond_with(:admin, @user)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_with(:admin, @user)
  end
end
