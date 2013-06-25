require 'spec_helper'

describe "Static pages" do

	let(:base_title) { "McGill EZ Notes" }

	describe "Home page" do

		it "should have the header h1 'McGill EZ Notes'" do
      visit '/static_pages/home'
      page.should have_selector('h1', :text => "#{base_title}" ) 
    end

    it "should have the header h1 'Welcome to McGill OSD EZ Notes'" do
      visit '/static_pages/home'
      page.should have_selector('h1', :text => "Welcome to McGill OSD EZ Notes" ) 
    end

    it "should have the title 'McGill EZ Notes'" do
      visit '/static_pages/home'
      page.should have_selector('title', :text => "#{base_title}" ) 
    end

	end
end
