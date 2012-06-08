require 'spec_helper'

describe "UserPages" do
	subject { page }
	describe  "signup page" do
		before { visit signup_path }
		check_h1_title('Sign Up', full_title('Sign Up'))
	end
	describe  "ProfielPage" do
		let(:user) { FactoryGirl.create(:user) }
		before{ visit user_path(user) }
		check_h1_title(user.name, user.name)
	end
end
