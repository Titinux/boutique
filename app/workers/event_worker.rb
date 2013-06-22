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

#require 'sidekiq/testing/inline'

class EventWorker
  include Sidekiq::Worker
  sidekiq_options queue: :events

  def perform(name, start, finish, id, payload)
                                       # name = 'event_name.myclass.my_module.event'
    a = name.split('.')[0..-2]         # a = ['event_name', 'myclass', 'my_module']
    function = a.shift                 # function = 'event_name' / a = ['myclass', 'my_module']
    a[0] += '_event_handler'           # a = ['myclass_event_handler', 'my_module']

    klass = a.reverse.map(&:camelize).join('::').safe_constantize # klass = MyModule::MyclassEventHandler

    if klass && klass.respond_to?(function)
      payload.merge!({ notification: { id: id, start: start, finish: finish }})
      klass.send(function, payload)
    end
  end
end
