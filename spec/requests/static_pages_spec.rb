require 'spec_helper'

describe "StaticPages" do
  describe "Home Page" do
  	it "should have h1 'Sandbox App'" do
  		visit "/static_pages/home"
  		page.should have_selector('h1', :text => "Sandbox App")
  	end
  	it "should have title 'Home'" do
  		visit "/static_pages/home"
  		page.should have_selector('title', :text => "Sandbox App")
    end
  end

  describe "Help Page" do
  	it "should have h1 'help'" do
  		visit "/static_pages/help"
  		page.should have_selector("h1", :text => "Help")
    end
    it "should have title 'Help'" do
      visit "/static_pages/help"
      page.should have_selector("title", :text => "Help")
  	end
  end
  
  describe "About Page" do
  	it "should have h1 'About'" do
  		visit "/static_pages/about"
  		page.should have_selector("h1", :text => "About")
    end
    it "should have title 'About'" do
      visit "/static_pages/about"
      page.should have_selector("title", :text => "About")
  	end
  end
end
