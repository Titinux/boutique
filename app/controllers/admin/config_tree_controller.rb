class Admin::ConfigTreeController < ApplicationController
  layout 'admin'

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
