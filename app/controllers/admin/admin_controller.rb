class Admin::AdminController < ApplicationController
  layout 'admin'
  
  before_filter :autorization
  
  private
  
  def autorization
    unless user_session.login? and user_session.user.admin
      flash[:error] = 'You\'re not allowed to browse admin section'
      redirect_to root_path
      false
    end
  end
end