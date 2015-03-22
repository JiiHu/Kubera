require 'rails_helper'

describe Category do
  it "has the name set correctly" do
    category = Category.new name:"food"

    expect(category.name).to eq("food")
  end

  it "doesn't have too short name" do
    category = Category.new name:"aa"

    expect(category).not_to be_valid
  end

  it "doesn't have too long name" do
    category = Category.new name:"abcdefghijklmnop"

    expect(category).not_to be_valid
  end

  it "returns its name with to_s" do
    user = User.create username:"Pekka"

    expect(user.to_s).to eq("Pekka")
  end


  it "is not saved without name" do
    user = FactoryGirl.create(:user)
    category = Category.create user:user

    expect(category).not_to be_valid
    expect(Category.count).to eq(0)
  end

end