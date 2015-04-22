
require 'rails_helper'

describe SessionsController do
  render_views


  describe "GET #new" do
    
    it "renders the #new view" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET #destroy" do

    it "deletes entry given in parametres" do
      get :destroy
      expect(session[:user_id]).to eq(nil)
    end
    
  end

  describe "POST #create" do

    let!(:user){ FactoryGirl.create(:user) }

    before(:each) { 
      request.env["HTTP_REFERER"] = "/"
    }

    describe "with valid params" do 
      it "creates user session" do
        params = {"username"=>"jonne", "password"=>"eses","password_confirmation"=>"eses"}
        post :create, params
        user = User.find_by username:"jonne"
        expect(session[:user_id]).to eq(user.id)
      end
    end

    describe "with invalid params" do 
      it "redirects to entries#new" do
        params = {"username"=>"jonne", "password"=>"cs","password_confirmation"=>"cs"}
        post :create, user:params
        expect(session[:user_id]).to eq(nil)
      end
    end

  end

end
