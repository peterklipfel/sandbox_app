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
		content 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
						tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
						quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
						consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
						cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
						proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
		user
	end
end