FactoryGirl.define do 

  factory :user do |u|
  	u.sequence(:email) { |n| "example_#{n}@example.com" }
  	password "f00bAr!"
  	password_confirmation "f00bAr!"
  end
	
end