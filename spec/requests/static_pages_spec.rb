require 'spec_helper'

describe "StaticPages" do
  subject{ page }
  describe "Home Page" do
    before{ visit root_path }
    check_h1_title("Sandbox", full_title(''))
  	it { should_not have_selector('title', :text => "Home")}
  end

  describe "Help Page" do
    before{ visit help_path }
    check_h1_title('Help', full_title('Help'))
  end
  
  describe "About Page" do
    before{ visit about_path }
    check_h1_title('About', full_title('About'))
  end

  describe "Contact Page" do
    before{ visit contact_path }
    check_h1_title('Contact', full_title('Contact'))
  end
end
