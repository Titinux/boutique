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
    @user = User.new(user_params.except(:confirmed))
    @user.save

    @user.confirm! if user_params[:confirmed] == '1'

    respond_with(:admin, @user)
  end

  def update
    @user = User.find(params[:id])

    @user.update_attributes(user_params.except(:confirmed))
    @user.confirm! if user_params[:confirmed] == '1'

    respond_with(:admin, @user)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_with(:admin, @user)
  end

  private

  def user_params
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    params.require(:user).permit(:name,
                                 :password,
                                 :password_confirmation,
                                 :dofusNicknames,
                                 :email,
                                 :guild_id,
                                 :pigMoneyBox,
                                 :gatherer,
                                 :confirmed,
                                 :blocked)
  end
end
