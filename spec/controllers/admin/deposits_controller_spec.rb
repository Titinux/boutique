require "spec_helper"

describe Admin::DepositsController do
  login_administrator

  describe "GET index" do
    it "assigns all deposits as @deposits" do
      deposit = Factory :deposit

      get :index
      assigns(:deposits).to_a.should eq([deposit])
    end
  end

  describe "GET new" do
    it "assigns a new deposit as @deposit" do
      get :new
      assigns(:deposit).should be_a_new(Deposit)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      before(:each) do
        user  = Factory :user
        asset = Factory :asset

        @deposit_attributes = Factory.attributes_for(:deposit).merge({
                                                                    :user_id => user.id.to_s,
                                                                    :asset_id => asset.id.to_s
                                                                    })
      end

      it "creates a new Deposit" do
        expect {
          post :create, :deposit => @deposit_attributes
        }.to change(Deposit, :count).by(1)
      end

      it "assigns a newly created deposit as @deposit" do
        post :create, :deposit => @deposit_attributes
        assigns(:deposit).should be_a(Deposit)
        assigns(:deposit).should be_persisted
      end

      it "redirects to the list of deposits" do
        post :create, :deposit => @deposit_attributes
        response.should redirect_to(admin_deposits_path)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved deposit as @deposit" do
        Deposit.any_instance.stub(:save).and_return(false)
        post :create, :deposit => {}
        assigns(:deposit).should be_a_new(Deposit)
      end

      it "re-renders the 'new' template" do
        Deposit.any_instance.stub(:save).and_return(false)
        Deposit.any_instance.stub(:errors).and_return({ 'error' => 'foo'})

        post :create, :deposit => {}
        response.should render_template("new")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested deposit" do
      deposit = Factory :deposit

      expect {
        delete :destroy, :id => deposit.id.to_s
      }.to change(Deposit, :count).by(-1)
    end

    it "redirects to the deposits list" do
      deposit = Factory :deposit

      delete :destroy, :id => deposit.id.to_s
      response.should redirect_to(admin_deposits_url)
    end
  end
end
