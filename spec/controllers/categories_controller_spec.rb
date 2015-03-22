
require 'rails_helper'

describe CategoriesController do
  render_views

  let!(:user){ FactoryGirl.create(:user) }
  
  before(:each) { 
    session[:user_id] = user.id
  }

  describe "GET index" do
    before(:each) { get :index }

    it "renders the :index view" do
      expect(response).to render_template :index
    end

    it 'to be success' do
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "assigns the requested category to @category" do
      category = FactoryGirl.create(:category, user:user) 
      get :show, id: category
      expect(assigns(:category)).to eq(category)
    end
    
    it "renders the #show view" do
      get :show, id: FactoryGirl.create(:category, user:user) 
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do

    before(:each) { get :new }

    it "assigns new category to @category" do
      expect(assigns(:category)).to be_a_new(Category)
    end
    
    it "renders the #new view" do
      expect(response).to render_template(:new)
    end
  end

  describe "GET #destroy" do

    it "deletes category given in parametres" do
      category = FactoryGirl.create(:category, user:user) 
      get :destroy, id: category
      expect(Category.count).to eq(0)
    end
    
  end

  describe "POST #create" do

    describe "with valid params" do 
      it "creates and saves category" do
        category_params = {"name"=>"food", "income"=>false}
        expect{
          post :create, category:category_params
        }.to change(Category,:count).by(1)
      end
    end

    describe "with invalid params" do 
      it "redirects to categories#new" do
        category_params = {"name"=>"a", "income"=>false}
        post :create, category:category_params
        expect(response).to render_template(:new)
      end
    end

  end

  describe "POST #update" do

    describe "with valid params" do 
      it "updates category" do
        category = FactoryGirl.create(:category, user:user)
        category_params = {"name"=>"food", "income"=>true}
        put :update, id:category.id, category:category_params

        category = Category.find_by name:"food"
        expect(category.income).to eq(true)
      end
    end

    describe "with invalid params" do 
      it "wont update category" do
        category = FactoryGirl.create(:category, user:user)
        category_params = {"name"=>"a", "income"=>false}
        put :update, id:category.id, category:category_params

        category = Category.find_by name:"food"
        expect(category).not_to eq(nil)

        category = Category.find_by name:"a"
        expect(category).to eq(nil)
      end
    end

  end

end
