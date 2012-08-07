require 'spec_helper'

describe "UserPages" do
	subject { page }

	describe 'index' do
		let (:user) { FactoryGirl.create(:user) }

		before(:all) { 30.times { FactoryGirl.create(:user) } }
		after(:all) { User.delete_all }
		before(:each) do
			sign_in user
			visit users_path
		end
		it { should have_selector 'title', :text => 'All Users' }
		it { should have_selector 'h1', :text => 'All Users' }

		describe 'pagination' do 
			it {should have_selector('div.pagination')}
			it 'should list paginated users' do 
				User.paginate(:page => 1).each do |user|
					page.should have_selector('li', :text => user.name)
				end
			end
		end
		describe 'delete links' do
			it { should_not have_link('delete') }
			describe 'as admin' do
				let(:admin) { FactoryGirl.create(:admin) }
				before do 
					sign_in admin
					visit users_path
				end
				it { should have_link('delete', :href => user_path(User.first)) }
				it 'should be able to delete user' do
					expect { click_link('delete') }.to change(User, :count).by(-1)
				end
				it { should_not have_link('delete', href: user_path(admin)) }
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
	  let!(:p1) { FactoryGirl.create(:micropost, :user => user, :content => 'How now brown cow') }
	  let!(:p2) { FactoryGirl.create(:micropost, :user => user, :content => 'Baz') }
	  before { visit user_path(user) }
	  # can't use 'check_h1_title(user.name, user.name)' for some reason
	  it { should have_selector('h1',    :text => user.name) }
	  it { should have_selector('title', :text => user.name) }
	  describe 'microposts' do 
	  	it { should have_content(p1.content) }
	  	it { should have_content(p2.content) }
	  	it { should have_content(user.microposts.count) }
	  end
	end
end
