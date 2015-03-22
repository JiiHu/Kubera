require 'rails_helper'

describe Entry do
  it "has the amount set correctly" do
    entry = Entry.new amount:12.00

    expect(entry.amount).to eq(12.00)
  end

  it "has the date set correctly" do
  	date = Date.new(2015, 3, 12)
    entry = Entry.new date:date

    expect(entry.date).to eq(date)
  end

  it "is not saved without amount" do
  	date = Date.new(2015, 3, 12)
  	user = FactoryGirl.create(:user)
    entry = Entry.create category_id:1, date:date, user:user

    expect(entry).not_to be_valid
    expect(Entry.count).to eq(0)
  end

  it "is not saved without category_id" do
  	date = Date.new(2015, 3, 12)
  	user = FactoryGirl.create(:user)
    entry = Entry.create amount:12.00, date:date, user:user

    expect(entry).not_to be_valid
    expect(Entry.count).to eq(0)
  end

  it "is not saved without user" do
  	date = Date.new(2015, 3, 12)
    entry = Entry.create amount:12.00, date:date, category_id:1

    expect(entry).not_to be_valid
    expect(Entry.count).to eq(0)
  end

end