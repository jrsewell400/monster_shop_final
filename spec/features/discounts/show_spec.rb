require 'rails_helper'

RSpec.describe "Discount Show Page" do 
  describe "- when I visit discount index and click discount name" do 
    it "then I am taken to a show page that show's that discount's info." do 
      merchant_1 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      m_user = merchant_1.users.create!(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, role: 1, email: 'merchant_megan@example.com', password: 'password')
      five_percent = merchant_1.discounts.create!(name: "5% Discount", description: "This discount applies once item quantity reaches 5 and remains until quantity reaches 10.", discount_amt: 0.05, req_qty: 5)
      ten_percent = merchant_1.discounts.create!(name: "10% Discount", description: "This discount applies once item quantity reaches 10 and remains until quantity reaches 15.", discount_amt: 0.1, req_qty: 10)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(m_user)
      
      visit "/merchant/discounts"

      within "#discount-#{five_percent.id}" do
        click_on five_percent.name
      end
      
      expect(page).to_not have_content(ten_percent.name)
      expect(page).to have_content(five_percent.name)
      expect(page).to have_content("Description: #{five_percent.description}")
      expect(page).to have_content("Discount Amount: #{five_percent.discount_amt}")
      expect(page).to have_content("Required Item Qty for Discount: #{five_percent.req_qty}")
    end 
  end 
end 