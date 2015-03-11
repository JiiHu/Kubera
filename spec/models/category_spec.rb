require 'rails_helper'

describe Category do
  it "has the name set correctly" do
    category = Category.new name:"food"

    expect(category.name).to eq("food")
  end

  it "returns its name with to_s" do
    user = User.create username:"Pekka"

    expect(user.to_s).to eq("Pekka")
  end


end