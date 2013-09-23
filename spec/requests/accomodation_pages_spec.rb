require 'spec_helper'

describe "AccomodationPages" do

   subject { page }

   let(:admin) { FactoryGirl.create(:admin) }
   let(:user) { FactoryGirl.create(:user) }

   describe "index" do

      describe "as non admin user" do
         before do
            sign_in user
            visit accomodations_path 
         end
         specify { expect(page).to have_title(full_title('')) }
      end

      describe "as admin user" do
         
         before do
            sign_in admin
            visit accomodations_path
         end

         it { should have_title(full_title('Accommodations')) }

      end
   end

   describe "Accomodations Import" do
      describe "as non admin user" do
         before do 
            sign_in user
            visit new_accomodation_path 
         end
         specify { expect(page).to have_title(full_title('')) }
      end

      describe "as admin user" do

         let(:submit) { "Import" }
         before do
            sign_in admin
            visit new_accomodation_path
         end

         it { should have_title(full_title('Accomodation Import')) }
         it { should have_content("Accomodation Import") }

         describe "with invalid information" do
            it "should not add accomodations" do
               expect { click_button submit }.not_to change(Accomodation, :count)
            end
         end

         describe "with valid information" do
            before do
              attach_file 'file', Rails.root.join('app', 'assets', 'files', 'generalaccomodations.csv')
            end

            it "should create an accomodations" do
               expect { click_button submit }.to change(Accomodation, :count).by(740)
            end
         end
      end
   end
end
