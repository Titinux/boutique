class CategoriesController < ApplicationController
  respond_to :html, :xml

  # GET /categories
  def index
    respond_with(@categories = Category.mainCategories)
  end

  # GET /category/1
  def show
    respond_with(@category = Category.find(params[:id]))
  end
end
