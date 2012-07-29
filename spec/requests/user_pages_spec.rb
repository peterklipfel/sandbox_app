require 'spec_helper'

describe "UserPages" do
	subject { page }

	describe 'index' do
		before do 
			sign_in FactoryGirl.create(:user)
			FactoryGirl.create(:user, :name => 'Feye', :email => 'feye@ter.re')
			FactoryGirl.create(:user, :name => 'Hava', :email => 'Hav@goo.dun')
			visit users_path
		end
		it { should have_selector 'title', :text => 'All Users' }
		it { should have_selector 'h1', :text => 'All Users' }

		it 'should list all users' do 
			User.all.each do |user|
				page.should have_selector('li', :text => user.name)
			end
		end
	end

	describe  "signup page" do
		before { visit signup_path }
		let(:submit) { "Create My Account" }

		describe "check title" do
			check_h1_title('Sign Up', full_title('Sign Up'))
		end
		
		describe "invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end
		end

		describe "valid information" do
			before do
				fill_in "Name", 					:with => "Ima Yooser"
				fill_in "Email",					:with => "stuff@golem.com"
				fill_in "Password",				:with => "g0odPaS$word!"
				fill_in "Confirmation",		:with => "g0odPaS$word!"
			end
			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end
		end
	end

  describe "profile page" do
	  let(:user) { FactoryGirl.create(:user) }
	  before { visit user_path(user) }
	  # can't use 'check_h1_title(user.name, user.name)' for some reason
	  it { should have_selector('h1',    :text => user.name) }
	  it { should have_selector('title', :text => user.name) }
	end
end
