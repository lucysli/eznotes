require 'spec_helper'

describe "Static pages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_title(full_title(page_title)) }
  end

	describe "Home page" do

    before { visit root_path }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"
	end

  describe "Help page" do
    before { visit help_path }
    let(:page_title) { 'Help' }

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }
    let(:page_title) { 'About Us' }

    it_should_behave_like "all static pages"
  end

  describe "Contact page" do

    before { visit contact_path }
    let(:page_title) { 'Contact' }

    it_should_behave_like "all static pages"
  end

  describe "signup page 2" do
    
    before { visit signup2_path }
    let(:page_title) { 'Notetaker Application 2' }

    it_should_behave_like "all static pages"

    it "should have the right links in the pager" do
      click_link "Next"
      expect(page).to have_title(full_title('Notetaker Application 3'))
      click_link "Previous"
      expect(page).to have_title(full_title('Notetaker Application'))
    end
  end

  describe "signup page 3" do
    
    before { visit signup3_path }
    let(:page_title) { 'Notetaker Application 3' }

    it_should_behave_like "all static pages"

    it "should have the right links in the pager" do
      click_link "Next"
      expect(page).to have_title(full_title('Notetaker Application 4'))
      
      click_link "Previous"
      expect(page).to have_title(full_title('Notetaker Application 2'))
    end
  end

  describe "signup page 4" do
    
    before { visit signup4_path }
    let(:page_title) { 'Notetaker Application 4' }

    it_should_behave_like "all static pages"

    it "should have the right links in the pager" do

      click_link "Previous"
      expect(page).to have_title(full_title('Notetaker Application 3'))
      click_link "Next"
      expect(page).to have_title(full_title('Notetaker Application 4'))
    end
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title('About Us'))
    click_link "Help"
    expect(page).to have_title(full_title('Help'))
    click_link "Contact"
    expect(page).to have_title(full_title('Contact'))
    click_link "Home"
    expect(page).to have_title(full_title(''))
    click_link "Apply to be a notetaker"
    expect(page).to have_title(full_title('Notetaker Application'))
    click_link "McGill EZ Notes"
    expect(page).to have_title(full_title(''))
  end
end
