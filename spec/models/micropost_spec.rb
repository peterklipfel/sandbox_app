require 'spec_helper'

describe 'Microposts' do 
	let(:user) { FactoryGirl.create(:user) }
	before do
		@micropost = Micropost.new(:content => 'Lorem') 
	end

	subject { @micropost }

	it { should respond_to :content }
	it { should respond_to :user_id }
end
