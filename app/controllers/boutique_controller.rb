class BoutiqueController < ApplicationController
  layout 'public'

  # GET /welcome
  def show
    @categories = Category.all

    respond_to do |format|
      format.html
    end
  end
end
