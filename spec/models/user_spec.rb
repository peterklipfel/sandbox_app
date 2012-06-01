# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe User do
  before  do
  	@user = User.new(:name => "Example User", :email => "user@example.com")
  end
  subject { @user }
  it { should respond_to(:name) }
  it { should respond_to(:email) }

  it { should be_valid }

  describe "invalid name should not be valid" do
  	before { @user.name = " " }
  	it { should_not be_valid }
  end

  describe "name too long should not be valid" do
  	before { @user.name = "a"*51 }
  	it { should_not be_valid }
  end

  describe "invalid email should not be valid" do
  	before { @user.email = " " }
  	it { should_not be_valid }
  end

  describe "invalid email" do
  	it "should be invalid" do
  		addresses = ['blam@rs,com', 'things_at_f.org', 'RAWR@huh.',
                   'sklip@fridge_beer.com', 'drop@table+AGH.com']
      addresses.each do |stuff|
      	@user.email = stuff
      	@user.should_not be_valid
      end
    end
  end

  describe "valid email," do
  	it "should be valid" do
  		addresses = ['i-mAWESOME_4@stuff.com', 'this.Is.@wierd.email.address',
  				 			 	 'stuff+THINGS@what.mX', 'bibble@england.co.uk']
	  	addresses.each do |stuff|
	  		@user.email = stuff
	  		@user.should be_valid
	  	end
  	end

  	describe "email already taken" do
  		before do
  			duplicate_user = @user.dup
  			duplicate_user.email = @user.email.upcase
  			duplicate_user.save
  		end
  		it { should_not be_valid }
  	end
  end
end
