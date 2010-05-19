class BoutiqueController < ApplicationController
  layout 'public'

  # GET /welcome
  def welcome
    @categories = Category.all

    respond_to do |format|
      format.html
    end
  end

  # GET /category
  def category
    if params[:cat]
      @category = Category.find(params[:cat])
      @subCategories = @category.subCategories
    else
      @subCategories = Category.mainCategories
    end
  end
end
