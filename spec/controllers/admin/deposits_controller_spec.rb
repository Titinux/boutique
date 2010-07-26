require "spec_helper"

describe Admin::DepositsController do

  def mock_deposit(stubs={})
    @mock_deposit ||= mock_model(Deposit, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns not validated deposits as @deposits"
  end

  describe "GET new" do
    it "assigns a new deposit as @deposit" do
      Deposit.stub(:new) { mock_deposit }
      get :new
      assigns(:deposit).should be(mock_deposit)
    end
  end

  describe "POST create" do

    describe "with valid params"
      it "redirects to the list of deposits" do
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved deposit as @deposit"

      it "re-renders the 'new' template"
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested deposit" do
      Deposit.should_receive(:find).with("42") { mock_deposit }
      mock_deposit.should_receive(:destroy)
      delete :destroy, :id => "42"
    end

    it "redirects to the deposits list" do
      Deposit.stub(:find) { mock_deposit }
      delete :destroy, :id => "1"
      response.should redirect_to(admin_deposits_url)
    end
  end
end
