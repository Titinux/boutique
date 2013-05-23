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
  before_filter :authenticate_user!, :except => [:new, :create]

  # GET /user
  # GET /user.xml
  def show
    respond_with(@user = current_user)
  end

  # GET /user/new
  def new
    respond_with(@user = User.new)
  end

  # GET /user/edit
  def edit
    respond_with(@user = current_user)
  end

  # POST /user
  # POST/user.xml
  def create
    @user = User.new(params[:user])
    @user.save

    flash[:notice] = t('devise.confirmations.send_instructions')
    respond_with(@user, :location => root_path)
  end

  # PUT /user
  # PUT /user.xml
  def update
    @user = current_user
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?

    @user.update_attributes(params[:user])

    respond_with(@user, :location => user_path)
  end
end
