require 'rails_helper'

describe Category do
  it "has the name set correctly" do
    category = Category.new name:"food"

    expect(category.name).to eq("food")
  end

end