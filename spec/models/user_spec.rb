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
  	@user = User.new(:name => "Example User", :email => "user@example.com",
                     :password => "babble", :password_confirmation => "babble")
  end
  subject { @user }
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

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

  describe "invalid password should not be valid" do
    before { @user.password = @user.password_confirmation = " " }
  end

  describe "mismatched password should not be valid" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "nil password should not be valid" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end
end