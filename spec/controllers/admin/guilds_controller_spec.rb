require "spec_helper"

describe Admin::GuildsController do
  login_administrator

  describe "GET index" do
    it "assigns all guilds as @guilds" do
      guild = Factory :guild

      get :index
      assigns(:guilds).to_a.should eq([guild])
    end
  end

  describe "GET show" do
    it "assigns the requested guild as @guild" do
      guild = Factory :guild

      get :show, :id => guild.id.to_s
      assigns(:guild).should eq(guild)
    end
  end

  describe "GET new" do
    it "assigns a new guild as @guild" do
      get :new
      assigns(:guild).should be_a_new(Guild)
    end
  end

  describe "GET edit" do
    it "assigns the requested guild as @guild" do
      guild = Factory :guild
      get :edit, :id => guild.id.to_s
      assigns(:guild).should eq(guild)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Guild" do
        expect {
          post :create, :guild => Factory.attributes_for(:guild)
        }.to change(Guild, :count).by(1)
      end

      it "assigns a newly created guild as @guild" do
        post :create, :guild => Factory.attributes_for(:guild)
        assigns(:guild).should be_a(Guild)
        assigns(:guild).should be_persisted
      end

      it "redirects to the created guild" do
        post :create, :guild => Factory.attributes_for(:guild)
        response.should redirect_to([:admin, Guild.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved guild as @guild" do
        Guild.any_instance.stub(:save).and_return(false)
        post :create, :guild => {}
        assigns(:guild).should be_a_new(Guild)
      end

      it "re-renders the 'new' template" do
        Guild.any_instance.stub(:save).and_return(false)
        Guild.any_instance.stub(:errors).and_return({ 'error' => 'foo'})

        post :create, :guild => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested guild" do
        guild = Factory :guild

        Guild.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => guild.id.to_s, :guild => {'these' => 'params'}
      end

      it "assigns the requested guild as @guild" do
        guild = Factory :guild

        put :update, :id => guild.id.to_s, :guild => Factory.attributes_for(:guild)
        assigns(:guild).should eq(guild)
      end

      it "redirects to the guild" do
        guild = Factory :guild

        put :update, :id => guild.id.to_s, :guild => Factory.attributes_for(:guild)
        response.should redirect_to([:admin, guild])
      end
    end

    describe "with invalid params" do
      it "assigns the guild as @guild" do
        guild = Factory :guild
        Guild.any_instance.stub(:save).and_return(false)

        put :update, :id => guild.id.to_s, :guild => {}
        assigns(:guild).should eq(guild)
      end

      it "re-renders the 'edit' template" do
        guild = Factory :guild
        Guild.any_instance.stub(:save).and_return(false)
        Guild.any_instance.stub(:errors).and_return({ 'error' => 'foo'})

        put :update, :id => guild.id.to_s, :guild => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested guild" do
      guild = Factory :guild

      expect {
        delete :destroy, :id => guild.id.to_s
      }.to change(Guild, :count).by(-1)
    end

    it "redirects to the guilds list" do
      guild = Factory :guild

      delete :destroy, :id => guild.id.to_s
      response.should redirect_to(admin_guilds_url)
    end
  end
end
