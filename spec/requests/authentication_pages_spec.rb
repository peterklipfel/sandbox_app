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
				fill_in :email,					:with => user.email
				fill_in :password,			:with => user.password
				click_button 'Sign In'
			
			end

			it { should have_selector('title',  :text => user.name) }
			it { should have_link('Profile', 		:href => user_path(user)) }
			it { should have_link('Sign Out', 	:href => signout_path) }
			it { should_not have_link('Sign in',:href => signin_path) }
		end

	end
end
