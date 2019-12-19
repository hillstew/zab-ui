require 'rails_helper'

RSpec.describe 'User Authentication' do
  describe 'When I visit the welcome page' do
    it "I see a Signup with YNAB button" do
      visit root_path

      expect(page).to have_button("Signup with YNAB")

      click_button "Signup with YNAB"
      
      expect(current_path).to eq('/signup')
    end
  end
end