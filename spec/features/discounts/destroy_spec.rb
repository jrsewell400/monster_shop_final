require 'rails_helper'

RSpec.describe "Discount Destroy Spec", type: :feature do 
  describe "- when I visit the discounts index page and click delete on a discount" do
    it "then it is removed from the index page." do 
      merchant_1 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      
      m_user = merchant_1.users.create!(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, role: 1, email: 'merchant_megan@example.com', password: 'password')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(m_user)

      five_percent = merchant_1.discounts.create!(name: "5% Discount", description: "This discount applies once item quantity reaches 5 and remains until quantity reaches 10.", discount_amt: 0.05, req_qty: 5)
      ten_percent = merchant_1.discounts.create!(name: "10% Discount", description: "This discount applies once item quantity reaches 10 and remains until quantity reaches 15.", discount_amt: 0.1, req_qty: 5)

      visit merchant_discounts_path 
      
      expect(page).to have_link("10% Discount")
      
      within "#discount-#{ten_percent.id}" do
        click_link "Delete Discount"
      end 
      
      expect(current_path).to eq(merchant_discounts_path)
      expect(page).to have_content("10% Discount has been removed from discounts.")
    end 
  end 
end 