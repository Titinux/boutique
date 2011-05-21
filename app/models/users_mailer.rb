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

class UsersMailer < ActionMailer::Base
  # TODO Utiliser un paramètre pour spécifier l'adresse d'expédition des mails de la boutique.
  default :from => 'no-reply@boutique.hyze.bagu.biz'

  def user_account_created(user)
    @user = user

    mail :to => user.email,
         :subject => "Your new account on boutique.hyze.bagu.biz"
  end

  def user_password_reset(user, new_password)
    @user = user
    @new_password = new_password

    mail :to => user.email,
         :subject => "Your account name on boutique.hyze.bagu.biz"
  end
end
