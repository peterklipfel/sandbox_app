FactoryGirl.define do
	factory :user do
		sequence(:name) { |i| "User_#{i}" }
		sequence(:email){ |j| "User_#{j}@example.com" }
		password							"thisisapassword"
		password_confirmation	"thisisapassword"
	end
end