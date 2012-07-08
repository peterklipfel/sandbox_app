require 'spec_helper'

describe "AuthenticationPages" do
	subject { page }
  describe "sign in page" do
  	before { visit signin_path }
  end

  describe 'signin' do
		before { visit signin_path }
		describe 'with invalid information' do
			before { click_button 'Sign In' }
	  	it { should have_selector('h1',    :text => 'Sign In') }
	    it { should have_selector('title', :text => 'Sign In') }

			describe 'flash message shouldn\'nt persist' do
				before { click_link 'Home'}
				it { should_not have_selector('div.alert.alert-error') }
			end
		end

		describe 'with valid information' do
			let(:user) { FactoryGirl.create(:user) }
			before do
				fill_in 'Email',					with: user.email
				fill_in 'Password',				with: user.password
				click_button 'Sign In'
			
			end
			it { should have_selector('h1',  		:text => user.name) }
			it { should have_link('Profile', 		:href => user_path(user)) }
			it { should have_link('Settings', 	:href => edit_user_path(user) }
			it { should have_link('Sign Out', 	:href => signout_path) }
			it { should_not have_link('Sign in',:href => signin_path) }
			it { should_not have_selector('div',:text => "Couldn't find that user/email combination")}
		end
	end

	describe 'Edit' do
		let(:user) { FactoryGirl.create(:user) }
		before { visit edit_user_path(user) }
		describe 'Page' do
			it { should have_selector('h1', :text => 'Update Your Profile') }
			it { should have_selector('title', :text => 'Edit User') }
			it { should have_link('change', :href => 'http://gravatar.com/emails') }
		end

		describe 'with invalid information' do
			before { click_button 'Save Changes' }

			it { should have_content 'Error' }
end
