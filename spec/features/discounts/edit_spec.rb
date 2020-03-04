require 'rails_helper'

RSpec.describe "Edit Discount", type: :feature do 
  describe "- when I visit the discount index page" do 
    it "I see a link to edit a current discount." do 
      merchant_1 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      merchant_2 = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      
      m_user = merchant_1.users.create!(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, role: 1, email: 'merchant@example.com', password: 'password')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(m_user)

      five_percent = merchant_1.discounts.create!(name: "5% Discount", description: "This discount applies once item quantity reaches 5 and remains until quantity reaches 10.", discount_amt: 0.05, req_qty: 5)
      ten_percent = merchant_1.discounts.create!(name: "10% Discount", description: "This discount applies once item quantity reaches 10 and remains until quantity reaches 15.", discount_amt: 0.1, req_qty: 5)
      
      seven_percent = merchant_2.discounts.create!(name: "7% Discount", description: "This discount applies once item quantity reaches 7 and remains until quantity reaches 17.", discount_amt: 0.07, req_qty: 7)
      eleven_percent = merchant_2.discounts.create!(name: "11% Discount", description: "This discount applies once item quantity reaches 11 and remains until quantity reaches 21.", discount_amt: 0.11, req_qty: 11)

      visit merchant_discounts_path

      within "#discount-#{five_percent.id}" do
        expect(page).to have_link("Edit Discount")
      end
    end 

    it "I can click a link to edit the discount and I'm taken to a form to edit the current discount." do 
      merchant_1 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      merchant_2 = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      
      m_user = merchant_1.users.create!(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, role: 1, email: 'merchant@example.com', password: 'password')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(m_user)

      five_percent = merchant_1.discounts.create!(name: "5% Discount", description: "This discount applies once item quantity reaches 5 and remains until quantity reaches 10.", discount_amt: 0.05, req_qty: 5)
      ten_percent = merchant_1.discounts.create!(name: "10% Discount", description: "This discount applies once item quantity reaches 10 and remains until quantity reaches 15.", discount_amt: 0.1, req_qty: 5)

      visit merchant_discounts_path

      within "#discount-#{five_percent.id}" do
        click_on "Edit Discount"
      end

      expect(current_path).to eq(edit_merchant_discount_path(five_percent.id))
    end

    it "I can click a link to edit a discount, and go through the motions to successfully update that discount." do 
      merchant_1 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      merchant_2 = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      
      m_user = merchant_1.users.create!(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, role: 1, email: 'merchant@example.com', password: 'password')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(m_user)

      five_percent = merchant_1.discounts.create!(name: "5% Discount", description: "This discount applies once item quantity reaches 5 and remains until quantity reaches 10.", discount_amt: 0.05, req_qty: 5)
      ten_percent = merchant_1.discounts.create!(name: "10% Discount", description: "This discount applies once item quantity reaches 10 and remains until quantity reaches 15.", discount_amt: 0.1, req_qty: 5)

      visit merchant_discounts_path

      within "#discount-#{five_percent.id}" do
        click_on "Edit Discount"
      end

      fill_in :Name, with: "99% Discount"
      fill_in :Description, with: "This discount applies once item quantity reaches 99."
      fill_in 'Discount Amount', with: 0.99
      fill_in 'Required Quantity', with: 99
      click_button 'Edit Discount'

      five_percent.reload

      expect(page).to have_content("99% Discount")
      expect(page).to_not have_content("5% Discount")
    end 
  end 
end