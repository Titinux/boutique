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

Factory.define :user do |u|
  u.sequence(:name)  {|n| "user#{n}" }
  u.email  {|a| "#{a.name}@example.com" }

  u.password "user_password"
  u.password_confirmation {|a| a.password }

  u.confirmed_at { DateTime.now }
end

Factory.define :gatherer, :parent => :user do |f|
  f.gatherer true
end
