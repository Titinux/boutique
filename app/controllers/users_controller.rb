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

class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:new, :create]

  def show
    respond_with(@user = current_user)
  end

  def new
    respond_with(@user = User.new)
  end

  def edit
    respond_with(@user = current_user)
  end

  def create
    @user = User.new(user_params)
    @user.save

    flash[:notice] = t('devise.confirmations.send_instructions')
    respond_with(@user, location: root_path)
  end

  def update
    @user = current_user
    @user.update_attributes(user_params)

    respond_with(@user, location: user_path)
  end

  private

  def user_params
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    params.require(:user).permit(:dofusNicknames, :password, :password_confirmation, :email, :guild_id)
  end
end
