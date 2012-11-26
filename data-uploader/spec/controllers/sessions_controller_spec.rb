require 'spec_helper'

describe SessionsController do

  describe "GET :new" do
    before do
      get :new
    end

    it "renders the login page" do
      expect(response).to render_template :new
    end
  end

  describe "GET :create" do

    context "on success" do

      context "with new auth info" do
        before do
          request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:openid]
        end

        it "creates a new User" do
          expect { get :create, provider: "openid" }.to change(User, :count).by(1)
        end

        it "sets the user_id in the session hash" do
          expect(session[:user_id]).to be_nil
          get :create, provider: "openid"
          expect(session[:user_id]).to_not be_nil
        end

        it "redirects to the home page" do
          get :create, provider: "openid"
          expect(response).to redirect_to root_path
        end
      end

      context "with an existing user with same auth info" do
        let!(:user) { Fabricate(:user) }

        before do
          request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:openid]
        end

        it "does not create a new User" do
          expect { get :create, provider: "openid" }.to_not change(User, :count)
        end

        it "sets the user_id in the session hash" do
          expect(session[:user_id]).to be_nil
          get :create, provider: "openid"
          expect(session[:user_id]).to_not be_nil
        end

        it "redirects to the home page" do
          get :create, provider: "openid"
          expect(response).to redirect_to root_path
        end
      end

    end

  end

  describe "GET :destroy" do
    let!(:user) { Fabricate(:user) }
    before { sign_in user }

    it "unsets the user_id in the session hash" do
      expect(session[:user_id]).to eq user.id
      get :destroy
      expect(session[:user_id]).to be_nil
    end

    it "redirects to the login page" do
      get :destroy
      expect(response).to redirect_to login_path
    end
  end

end