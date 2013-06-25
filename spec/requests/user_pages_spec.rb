require 'spec_helper'

describe "User pages" do

	subject { page }

	describe "signup page" do
		before { visit signup_path }

		it { should have_selector('h1',	text: 'Notetaker Application') }
		it { should have_selector('title',	text: full_title('Note-Taker Sign up')) }
  end
end
