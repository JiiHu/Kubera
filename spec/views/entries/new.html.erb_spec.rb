require 'rails_helper'

RSpec.describe "entries/new", type: :view do
  before(:each) do
    assign(:entry, Entry.new(
      :amount => "9.99",
      :user_id => 1,
      :category_id => 1
    ))
  end

  it "renders new entry form" do
    render

    assert_select "form[action=?][method=?]", entries_path, "post" do

      assert_select "input#entry_amount[name=?]", "entry[amount]"

      assert_select "input#entry_user_id[name=?]", "entry[user_id]"

      assert_select "input#entry_category_id[name=?]", "entry[category_id]"
    end
  end
end
