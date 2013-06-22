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

class Admin::StatisticsController < Admin::AdminController

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render xml: @statlist }
    end
  end

  def show
    redirect_to action: 'index' and return unless Statistics.respond_to?("#{params[:id].downcase}Stats")

    @stats = Statistics.send("#{params[:id].downcase}Stats")

    respond_to do |format|
      format.html { render template: "admin/statistics/#{params[:id]}" }
      format.xml  { render xml: @stats }
    end
  end
end
