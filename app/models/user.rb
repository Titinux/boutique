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

class User < ActiveRecord::Base
  devise :database_authenticatable, :confirmable, :validatable,
         :timeoutable, :recoverable, :trackable, :lockable, :encryptable,
         :encryptor => :boutique_encryptor,
         :unlock_strategy => :email,
         :timeout_in => 15.days

  # Associations
  belongs_to :guild

  has_many :deposits
  has_many :orders
  has_many :carts

  # Attributes
  attr_accessible :name, :email, :password, :password_confirmation,
                  :pigMoneyBox, :dofusNicknames, :guild_id, :gatherer,
                  :blocked

  attr_searchable  :name, :gatherer
  assoc_searchable :guild, :deposits

  #Validations
  validates :name, :presence => true, :uniqueness => true, :length => 3..25, :allow_blank => false

  validates_associated :guild
  validates_associated :deposits

  validates_length_of :dofusNicknames, :maximum => 255, :allow_blank => true

  def self.find_for_database_authentication(conditions)
    value = conditions[authentication_keys.first]
    User.unscoped.where("name = ? or email = ?", value, value).first
  end

  def addMoney
    @addMoney ||= 0
  end

  def addMoney=(value)
    @addMoney = value.to_i
    self.pigMoneyBox ||= 0

    self.pigMoneyBox += @addMoney
  end

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

  def cart
    cart = self.carts.where(:current => true).first

    cart ||= self.carts.create(:current => true)
  end
end
