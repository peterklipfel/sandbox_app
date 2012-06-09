require 'spec_helper'

describe "UserPages" do
	subject { page }
	describe  "signup page" do
		before { visit signup_path }
		check_h1_title('Sign Up', full_title('Sign Up'))
	end	
  describe "profile page" do
	  let(:user) { FactoryGirl.create(:user) }
	  before { visit user_path(user) }
	  # can't use 'check_h1_title(user.name, user.name)' for some reason
	  it { should have_selector('h1',    :text => user.name) }
	  it { should have_selector('title', :text => user.name) }
	end
end
