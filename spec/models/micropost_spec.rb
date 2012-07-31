require 'spec_helper'

describe 'Microposts' do 
	let(:user) { FactoryGirl.create(:user) }
	before { @micropost = user.microposts.build(:content =>'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
																													tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
																													quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
																													consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
																													cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
																													proident, sunt in culpa qui officia deserunt mollit anim id est laborum.') }

	subject { @micropost }

	it { should respond_to :content }
	it { should respond_to :user_id }
	it { should respond_to :user }
	its(:user) { should == user }

	it { should be_valid }

	describe 'when user_id is not present' do
		before { @micropost.user_id = nil }
		it { should_not be_valid }
	end
	describe 'when content is blank' do
		before {@micropost.content = ' ' }
		it { should_not be_valid }
	end
	describe 'when content is too long' do
		before { @micropost.content = 'a' * 141 }
		it { should_not be_valid }
	end
	describe 'accessible attributes' do
		it 'shouldn\'t allow access to user_id' do
			expect do
				Micropost.new(:user_id => user.id)
			end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end
end
