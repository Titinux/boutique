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

module LogTools
  def self.log_me(record, *args)
    options = args.extract_options!
    options[:level]      ||= 0
    options[:user]       ||= 'unknow'
    options[:action]     ||= 'unknow'
    options[:objectType] ||= record.class.name
    options[:objectId]   ||= record.id
    options[:data]       ||= record.attributes

    Log.create(:level => options[:level],
               :user => options[:user],
               :action => options[:action],
               :objectType => options[:objectType],
               :objectId => options[:objectId],
               :data => options[:data])
  end
end
