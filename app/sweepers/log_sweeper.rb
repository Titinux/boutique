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

class LogSweeper < ActionController::Caching::Sweeper
  observe Asset, Category, Deposit, Guild, Job, Order, OrderLine, User

  def after_create(record)
    LogTools::log_me(record, { :user => current_user_name, :action => 'create' })
  end

  def after_update(record)
    LogTools::log_me(record, { :user => current_user_name, :action => 'update', :data => record.attributes.merge(record.changes) })
  end

  def before_destroy(record)
    LogTools::log_me(record, { :user => current_user_name, :action => 'destroy' })
  end

  private

  def current_user_name
    if user_session.nil?
      'system'
    elsif user_session.login?
      user_session.user.name
    else
      'anonymous'
    end
  end
end
