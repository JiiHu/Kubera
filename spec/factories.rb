FactoryGirl.define do

  factory :user do
    username "jonne"
    password "eses"
    password_confirmation "eses"
  end

  factory :category do
    name "food"
    user
    income false
  end

  factory :entry do
  	amount 9.90
  	date Date.new(2015, 03, 21)
    category
    user
  end

end