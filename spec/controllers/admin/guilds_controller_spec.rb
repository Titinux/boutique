require "spec_helper"

describe Admin::GuildsController do

  def mock_guild(stubs={})
    @mock_guild ||= mock_model(Guild, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all guilds as @guilds" do
      Guild.stub(:all) { [mock_guild] }
      get :index
      assigns(:guilds).should eq([mock_guild])
    end
  end

  describe "GET show" do
    it "assigns the requested guild as @guild" do
      Guild.stub(:find).with("42") { mock_guild }
      get :show, :id => "42"
      assigns(:guild).should be(mock_guild)
    end
  end

  describe "GET new" do
    it "assigns a new guild as @guild" do
      Guild.stub(:new) { mock_guild }
      get :new
      assigns(:guild).should be(mock_guild)
    end
  end

  describe "GET edit" do
    it "assigns the requested guild as @guild" do
      Guild.stub(:find).with("37") { mock_guild }
      get :edit, :id => "37"
      assigns(:guild).should be(mock_guild)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created guild as @guild" do
        Guild.stub(:new).with({"these" => "params"}) { mock_guild(:save => true) }
        post :create, :guild => {"these" => "params"}
        assigns(:guild).should be(mock_guild)
      end

      it "redirects to the created guild" do
        Guild.stub(:new) { mock_guild(:save => true) }
        post :create, :guild => {}
        response.should redirect_to(admin_guild_url(mock_guild))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved guild as @guild" do
        Guild.stub(:new).with({"these" => "params"}) { mock_guild(:save => false) }
        post :create, :guild => {"these" => "params"}
        assigns(:guild).should be(mock_guild)
      end

      it "re-renders the 'new' template" do
        Guild.stub(:new) { mock_guild(:save => false) }
        post :create, :guild => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested guild" do
        Guild.should_receive(:find).with("42") { mock_guild }
        mock_guild.should_receive(:update_attributes).with({"these" => "params"})
        put :update, :id => "42", :guild => {"these" => "params"}
      end

      it "assigns the requested guild as @guild" do
        Guild.stub(:find) { mock_guild(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:guild).should be(mock_guild)
      end

      it "redirects to the guild" do
        Guild.stub(:find) { mock_guild(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(admin_guild_url(mock_guild))
      end
    end

    describe "with invalid params" do
      it "assigns the guild as @guild" do
        Guild.stub(:find) { mock_guild(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:guild).should be(mock_guild)
      end

      it "re-renders the 'edit' template" do
        Guild.stub(:find) { mock_guild(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested guild" do
      Guild.should_receive(:find).with("42") { mock_guild }
      mock_guild.should_receive(:destroy)
      delete :destroy, :id => "42"
    end

    it "redirects to the guilds list" do
      Guild.stub(:find) { mock_guild }
      delete :destroy, :id => "1"
      response.should redirect_to(admin_guilds_url)
    end
  end
end
