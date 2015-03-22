
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
    assigns(:category).should eq(category)
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
  
  it "renders the #show view" do
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

end
