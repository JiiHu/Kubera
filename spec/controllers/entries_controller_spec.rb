
require 'rails_helper'

describe EntriesController do
  render_views

  let!(:user){ FactoryGirl.create(:user) }
  let!(:category){ FactoryGirl.create(:category, user:user) }
  let!(:entry){ FactoryGirl.create(:entry, user:user, category:category) }
  
  before(:each) { 
    session[:user_id] = user.id
  }

  describe "GET #index" do
    before(:each) { get :index }

    it "renders the :index view" do
      expect(response).to render_template :index
    end

    it 'to be success' do
      expect(response).to be_success
    end
  end


  describe "GET #stats" do

    before(:each) { get :stats }

    it "renders the #stats view" do
      expect(response).to render_template(:stats)
    end
  end


  describe "GET #view" do
    before(:each) { get :view, year:2015, month:3 }

    it "renders the :view view" do
      expect(response).to render_template :view
    end

    it 'to be success' do
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "assigns the requested entry to @entry" do
      get :show, id: entry
      expect(assigns(:entry)).to eq(entry)
    end
    
    it "renders the #show view" do
      get :show, id: entry 
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do

    before(:each) { get :new }

    it "assigns new entry to @entry" do
      expect(assigns(:entry)).to be_a_new(Entry)
    end
    
    it "renders the #new view" do
      expect(response).to render_template(:new)
    end
  end

  describe "GET #destroy" do

    it "deletes entry given in parametres" do
      get :destroy, id: entry
      expect(Entry.count).to eq(0)
    end
    
  end

  describe "POST #create" do

    describe "with valid params" do 
      it "creates and saves entry" do
        entry_params = {"amount"=>"4.50", "date(1i)"=>"2015", "date(2i)"=>"3", "date(3i)"=>"22", "category_id"=>category.id}
        expect{
          post :create, entry:entry_params
        }.to change(Entry,:count).by(1)
      end
    end

    describe "with invalid params" do 
      it "redirects to entries#new" do
        entry_params = {"amount"=>"4.50", "date(1i)"=>"2015", "date(2i)"=>"3", "date(3i)"=>"22", "category_id"=>nil}
        post :create, entry:entry_params
        expect(response).to render_template(:new)
      end
    end

  end

  describe "POST #update" do

    describe "with valid params" do 
      it "updates entry" do
        entry_params = {"amount"=>"3.0", "date(1i)"=>"2015", "date(2i)"=>"3", "date(3i)"=>"22", "category_id"=>category.id}

        put :update, id:entry.id, entry:entry_params

        entry2 = Entry.find_by amount:3.0
        expect(entry2.amount).to eq(3.0)
      end
    end

    describe "with invalid params" do 
      it "wont update category" do

      end
    end

  end

end
