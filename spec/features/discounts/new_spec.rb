require 'rails_helper'

RSpec.describe "Create New Discount" do 
  describe "- when I go to the discounts index page and click on Create New Discount" do 
    it "then I am taken to a page where I can create a new discount." do 
      merchant_1 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      
      m_user = merchant_1.users.create!(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, role: 1, email: 'merchant_megan@example.com', password: 'password')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(m_user)

      five_percent = merchant_1.discounts.create!(name: "5% Discount", description: "This discount applies once item quantity reaches 5 and remains until quantity reaches 10.", discount_amt: 0.05, req_qty: 5)
      ten_percent = merchant_1.discounts.create!(name: "10% Discount", description: "This discount applies once item quantity reaches 10 and remains until quantity reaches 15.", discount_amt: 0.1, req_qty: 5)

      visit merchant_discounts_path

      click_link "Create New Discount"
      
      fill_in :Name, with: "15% Discount"
      fill_in :Description, with: "This discount applies once item quantity reaches 15 and remains until quantity reaches 20."
      fill_in 'Discount Amount', with: 0.15
      fill_in 'Required Quantity', with: 15
      click_button 'Create Discount'
      
      expect(current_path).to eq(merchant_discounts_path)
      expect(page).to have_link("15% Discount")

      click_on "15% Discount"
      
      expect(page).to have_content("Description: This discount applies once item quantity reaches 15 and remains until quantity reaches 20.")
      expect(page).to have_content("Discount Amount: 0.15")
      expect(page).to have_content("Required Item Qty for Discount: 15")
    end 

    it "then I don't fill in all the fields and get a error flash message." do
      merchant_1 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      
      m_user = merchant_1.users.create!(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, role: 1, email: 'merchant_megan@example.com', password: 'password')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(m_user)

      five_percent = merchant_1.discounts.create!(name: "5% Discount", description: "This discount applies once item quantity reaches 5 and remains until quantity reaches 10.", discount_amt: 0.05, req_qty: 5)
      ten_percent = merchant_1.discounts.create!(name: "10% Discount", description: "This discount applies once item quantity reaches 10 and remains until quantity reaches 15.", discount_amt: 0.1, req_qty: 5)

      visit merchant_discounts_path

      click_link "Create New Discount"
      
      fill_in 'Required Quantity', with: "15"
      fill_in 'Description', with: "This discount applies once item quantity reaches 15 and remains until quantity reaches 20."
      fill_in 'Discount Amount', with: 0.15
      click_button 'Create Discount'

      expect(current_path).to eq(new_merchant_discount_path)
      expect(page).to have_content("Please fill in all fields in order to create a discount.")
    end

    it "then I enter a non-unique discount amount and get an error on name and discount amount." do 
      merchant_1 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      
      m_user = merchant_1.users.create!(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, role: 1, email: 'merchant_megan@example.com', password: 'password')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(m_user)

      five_percent = merchant_1.discounts.create!(name: "5% Discount", description: "This discount applies once item quantity reaches 5 and remains until quantity reaches 10.", discount_amt: 0.05, req_qty: 5)
      ten_percent = merchant_1.discounts.create!(name: "10% Discount", description: "This discount applies once item quantity reaches 10 and remains until quantity reaches 15.", discount_amt: 0.1, req_qty: 10)

      visit merchant_discounts_path

      click_link "Create New Discount"
      
      fill_in 'Name', with: "10% Discount"
      fill_in 'Description', with: "Discount info."
      fill_in 'Discount Amount', with: 0.10
      fill_in 'Required Quantity', with: 10

      click_button 'Create Discount'

      expect(page).to have_content("discount_amt: [\"has already been taken\"]")
      expect(page).to have_content("name: [\"has already been taken\"]")
    end
  end 
end 

