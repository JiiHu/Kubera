
require 'rails_helper'

describe WelcomeController do
  render_views

  describe "GET index" do

    before(:each) { get :index }

    it "renders the :index view" do
      expect(response).to render_template :index
    end

    it 'to be success' do
      expect(response).to be_success
    end
  end

end
