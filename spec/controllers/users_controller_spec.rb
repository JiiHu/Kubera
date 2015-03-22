
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
        assigns(:user).should eq(user)
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



          user = User.new username:"juuh", password:"eli", password_confirmation:"eli"
          user_params = {"username"=>"5555", "password"=>"5555", "password_confirmation"=>"5555"}
          post :create, user:user_params
          expect(User.count).to eq(1)

        end
        
        it "renders the #index view" do
          expect(response).to render_template(:index)
        end
      end
    end

  end

end
