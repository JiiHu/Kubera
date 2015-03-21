require 'rails_helper'

describe Entry do
  it "has the amount set correctly" do
    entry = Entry.new amount:12.00

    expect(entry.amount).to eq(12.00)
  end


end