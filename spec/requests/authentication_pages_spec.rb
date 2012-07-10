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
			it { should have_link('Settings', 	:href => edit_user_path(user)) }
			it { should have_link('Sign Out', 	:href => signout_path) }
			it { should_not have_link('Sign in',:href => signin_path) }
			it { should_not have_selector('div',:text => "Couldn't find that user/email combination")}
		end
	end

	describe 'Edit' do
		let(:user) { FactoryGirl.create(:user) }
		before do 
			sign_in(user)
			visit edit_user_path(user)
		end
		describe 'Page' do
			it { should_not have_content 'Sign In' }
			it { should have_selector('h1', :text => 'Update Your Profile') }
			it { should have_selector('title', :text => 'Edit User') }
			it { should have_link('change', :href => 'http://gravatar.com/emails') }
		end

		describe 'with invalid information' do
			before { click_button 'Save Changes' }

			it { should have_content 'error' }
		end

		describe 'with valid information' do
			let(:new_email) { 'fwoop@shoop.oop' }
			let(:new_name) { 'Anoo Idantt' }
			before do
				fill_in 'Name', 						with: new_name
				fill_in 'Email', 						with: new_email
				fill_in 'Password', 				with: user.password
				fill_in 'Confirm Password', with: user.password
				click_button 'Save Changes' 
			end
			it { should have_selector('title', :text => new_name) }
			it { should have_selector('div.alert.alert-success') }
			it { should have_link('Sign Out', :href => signout_path) }
			specify { user.reload.name.should == new_name }
			specify { user.reload.email.should == new_email }
		end
	end

	describe 'authorization' do
		let(:user) { FactoryGirl.create(:user) }
		describe 'as wrong user' do
			let(:other_user) { FactoryGirl.create(:user, :email => 'im@bit.dif') }
			before { sign_in user }
			describe 'visiting the Edit-User page' do
				before { visit edit_user_path(other_user) }
				it { should_not have_selector(:title, :text => full_title('Edit User')) }
			end
			describe 'submitting a put request to the "update user" action' do
				before{ put user_path(other_user) }
				specify { response.should redirect_to root_path}
			end
		end

		describe 'for users that aren\'t signed in' do
			describe 'when trying to visit private page' do
				before do
					visit edit_user_path(user)
					fill_in 'Email', with: user.email
					fill_in 'Password', with: user.password
					click_button 'Sign In'
				end
				describe 'after sign in' do
					it 'should render the desired private page' do
						page.should have_selector('title', :text => 'Edit User')
					end
				end
			end

			describe 'in users controller' do
				describe 'visiting the edit page' do
					before { visit edit_user_path(user) }
					it { should have_selector('title', :text => 'Sign In') }
				end
				describe 'submitting to the update action' do
					before { put user_path(user) }
					specify { response.should redirect_to(signin_path) }
				end
			end
		end
	end
end	
