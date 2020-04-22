  require 'rails_helper'

RSpec.describe "As a user", type: :feature do
  describe "when I add enough of an item to my cart" do
    before :each do
        @r_user = User.create!(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'megan@example.com', password: 'securepassword')
        @megan = Merchant.create!(name: 'Megans Creatures', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
        @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 10, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 20)
        @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 10, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
        @five_percent = @megan.discounts.create!(name: "5% Discount", description: "This discount applies once item quantity reaches 5 and remains until quantity reaches 10.", discount_amt: 0.05, req_qty: 5)
        @ten_percent = @megan.discounts.create!(name: "10% Discount", description: "This is a 10% discount", discount_amt: 0.1, req_qty: 10)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@r_user)
    end

    it "then I see a discount applied to the price of items I am ordering." do
      visit item_path(@ogre.id)
      click_on "Add to Cart"
      visit cart_path

      expect(page).to_not have_content("A discount has been applied to this order!")

      4.times {click_on "More of This!"}

      expect(page).to have_content("Quantity: 5")
      expect(page).to have_content("Subtotal: $47.50")
      expect(page).to have_content("Total: $47.50")
      expect(page).to have_content("A discount has been applied to this order!")
    end

    it "then I can see the appropriate discount applied." do
      visit item_path(@ogre.id)
      click_on "Add to Cart"
      visit cart_path

      4.times {click_on "More of This!"}

      expect(page).to have_content("Quantity: 5")
      expect(page).to have_content("Total: $47.50")
      expect(page).to have_content("Subtotal: $47.50")
      expect(page).to have_content("A discount has been applied to this order!")

      5.times {click_on "More of This!"}

      expect(page).to have_content("Quantity: 10")
      expect(page).to have_content("Total: $90.00")
      expect(page).to have_content("Subtotal: $90.00")
      expect(page).to have_content("A discount has been applied to this order!")

      click_button 'Check Out'

      expect(page).to have_content("Total: $90.00")
    end
  end
end