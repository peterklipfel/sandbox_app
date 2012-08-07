require 'spec_helper'

describe "MicropostPages" do
	subject { page }

	let (:user) { FactoryGirl.create(:user) }
	before { sign_in user }
	describe 'creation of a micropost' do
		before { visit root_path }
		describe 'with invalid information' do
			it 'should not create a micropost' do
				expect { click_button 'Post' }.should_not change(Micropost, :count)
			end
			describe 'error messages' do
				before { click_button "Post" }
				it { should have_content('error') }
			end
		end
	  describe 'with valid information' do

	  	before { fill_in 'micropost_content', :with => 'Bawoggle'}
	  	it 'should create a micropost' do
	  		expect { click_button 'Post' }.should change(Micropost, :count).by(1)
	  	end
	  end
	end
end
