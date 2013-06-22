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

class ApplicationController < ActionController::Base
  protect_from_forgery

  self.responder = ApplicationResponder
  respond_to :html

  layout 'public'

  before_filter :set_locale_from_url

#
#  #cache_sweeper :log_sweeper
#

  def set_locale_from_url
    I18n.locale = if params[:locale] && I18n.available_locales.include?(params[:locale].to_sym)
      params[:locale]
    else
      I18n.default_locale
    end
  end

  def self.default_url_options(options={})
    options.merge({ locale: I18n.locale })
  end
end
