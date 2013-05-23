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

class Administrator < ActiveRecord::Base
  devise :database_authenticatable, :trackable, :validatable,
         :lockable, :timeoutable, :unlock_strategy => :none

  # Validations
  validates :name,  presence: true, uniqueness: { case_sensitive: false }, length: { within: 3..25 }, allow_blank: false
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { within: 3..25 }, email: true

  def blocked=(value)
    if value == '1'
      self.locked_at = Time.now unless self.blocked
    else
      self.locked_at = nil
    end
  end

  def blocked
    ! self.locked_at.nil?
  end
end
