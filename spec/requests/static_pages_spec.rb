require 'spec_helper'

describe "StaticPages" do
  describe "Home Page" do
  	it "should have content 'Sample App'" do
  		visit "/static_pages/home"
  		page.should have_content("Sample App")
  	end
  end  	
  describe "Help Page" do
  	it "should have content 'help'" do
  		visit "/static_pages/help"
  		page.should have_content("Help")
  	end
  end
  describe "About Page" do
  	it "should have content 'About'" do
  		visit "/static_pages/about"
  		page.should have_content("about")
  	end
  end
end
