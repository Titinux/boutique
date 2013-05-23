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

class WidgetCell < Cell::Rails
  include Devise::Controllers::Helpers
  helper  ApplicationHelper
  helper  ActionsHelper

  def user
    @user = current_user

    render
  end

  def cart
    if user_signed_in?
      @cart = current_user.cart

      render
    end
  end

  def carts
    if user_signed_in?
      @carts = current_user.carts

      render
    end
  end

  def deposits
    render
  end
end
