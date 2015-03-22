
require 'rails_helper'

describe UsersController do
  render_views

  let!(:user){ FactoryGirl.create(:user) }

  describe "when logged in" do
  
    before(:each) { 
      session[:user_id] = user.id
    }

    describe "GET #show" do
      it "assigns the requested user to @user" do 
        get :show, id: user
        expect(assigns(:user)).to eq(user)
      end
      
      it "renders the #show view" do
        get :show, id: user
        expect(response).to render_template(:show)
      end
    end

    describe "GET #new" do
      before(:each) { get :new }

      it "assigns new user to @user" do
        expect(assigns(:user)).to be_a_new(User)
      end
      
      it "renders the #show view" do
        expect(response).to render_template(:new)
      end
    end

    describe "GET #destroy" do
      it "deletes user given in parametres" do
        get :destroy, id: user
        expect(User.count).to eq(0)
      end
    end

  end

  describe "when not logged in" do

    describe "POST #create" do

      describe "with valid params" do 
        it "creates and saves user" do
          user_params = {"username"=>"juuh", "password"=>"elikka", "password_confirmation"=>"elikka"}
          expect{
            post :create, user:user_params
          }.to change(User,:count).by(1)
        end
      end

      describe "with invalid params" do 
        it "redirects to users#new" do
          user_params = {"username"=>"asd", "password"=>"asd", "password_confirmation"=>"asd"}
          post :create, user:user_params
          expect(response).to render_template(:new)
        end
      end

    end

  end

end
