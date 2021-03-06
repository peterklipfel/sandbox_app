FactoryGirl.define do
	factory :user do
		sequence(:name) { |i| "User_#{i}" }
		sequence(:email){ |j| "User_#{j}@example.com" }
		password							"thisisapassword"
		password_confirmation	"thisisapassword"
		
		factory :admin do
			admin true
		end
	end

	factory :micropost do
		content 'Lorem ipsum dolor sit amet, consectetur adipisicing elit'
		user
	end
end