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

class Admin::ConfigTreeController < Admin::AdminController

  # GET /admin/config_tree
  # GET /admin/config_tree.xml
  def index
    @configElements = ConfigTree.root.all_children

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @configElements }
    end
  end

  # GET /admin/configtree
  def edit
    @configElement = ConfigTree.find(params[:id])

    if params[:edit] == 'tree'
      render :action => 'edit_tree'
    else
      render :action => 'edit_value'
    end
  end

  # PUT /admin/config_tree/1
  # PUT /admin/config_tree/1.xml
  def update
    @configElement = ConfigTree.find(params[:id])

    respond_to do |format|
      if @configElement.update_attributes(params[:config_tree])
        flash[:notice] = 'Config element was successfully updated.'
        format.html { redirect_to(admin_config_tree_index_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @configElement.errors, :status => :unprocessable_entity }
      end
    end
  end
end
