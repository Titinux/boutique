class BoutiqueController < ApplicationController
  layout 'public'
  
   # GET /boutique/welcome
  def welcome
    @categories = Category.find(:all)
  end
  
  def category
    if params[:cat]
      @category = Category.find(params[:cat])
      @subCategories = @category.subCategories
    else
      @subCategories = Category.mainCategories
    end
  end
end
