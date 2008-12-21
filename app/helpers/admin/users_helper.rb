module Admin::UsersHelper

  def add_deposite_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, 'deposites', :partial => 'deposite_dform', :locals => { :deposite => Deposite.new }
    end
  end
end
