class CategoriesController < ApplicationController
  layout 'public'

  # GET /categories
  def index
    @categories = Category.mainCategories
  end

  # GET /category/1
  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @category }
    end
  end
end
