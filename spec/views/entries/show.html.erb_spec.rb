require 'rails_helper'

RSpec.describe "entries/show", type: :view do
  before(:each) do
    @entry = assign(:entry, Entry.create!(
      :amount => "9.99",
      :user_id => 1,
      :category_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
