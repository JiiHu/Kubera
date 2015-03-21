require 'rails_helper'

RSpec.describe "entries/index", type: :view do
  before(:each) do
    assign(:entries, [
      Entry.create!(
        :amount => "9.99",
        :user_id => 1,
        :category_id => 2
      ),
      Entry.create!(
        :amount => "9.99",
        :user_id => 1,
        :category_id => 2
      )
    ])
  end

  it "renders a list of entries" do
    render
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
