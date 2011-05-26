module ControllerMacros
  def login_administrator
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:administrator]
      sign_in Factory.create(:administrator)
    end
  end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = Factory.create(:user)
      sign_in @user
    end
  end
end
