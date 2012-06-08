FactoryGirl.define do
	factory :user do
		name									"Test User"
		email									"test@example.com"
		password							"thisisapassword"
		password_confirmation	"thisisapassword"
	end
end