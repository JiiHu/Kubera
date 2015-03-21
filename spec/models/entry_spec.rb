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


end