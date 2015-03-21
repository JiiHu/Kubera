require 'rails_helper'

RSpec.describe "entries/edit", type: :view do
  before(:each) do
    @entry = assign(:entry, Entry.create!(
      :amount => "9.99",
      :user_id => 1,
      :category_id => 1
    ))
  end

  it "renders the edit entry form" do
    render

    assert_select "form[action=?][method=?]", entry_path(@entry), "post" do

      assert_select "input#entry_amount[name=?]", "entry[amount]"

      assert_select "input#entry_user_id[name=?]", "entry[user_id]"

      assert_select "input#entry_category_id[name=?]", "entry[category_id]"
    end
  end
end
