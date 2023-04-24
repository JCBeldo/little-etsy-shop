require 'rails_helper'

RSpec.describe 'Merchant/bulk_discount new page', type: :feature do
  let!(:merchant) { create(:merchant) }
  let!(:merchant_1) { create(:merchant) }
  
  let!(:item_1) { create(:item, merchant_id: merchant.id) }
  let!(:item_2) { create(:item, merchant_id: merchant.id) }
  let!(:item_3) { create(:item, merchant_id: merchant.id) }
  let!(:item_4) { create(:item, merchant_id: merchant.id) }
  let!(:item_5) { create(:item, merchant_id: merchant.id) }
  let!(:item_6) { create(:item, merchant_id: merchant.id) }
  let!(:item_7) { create(:item, merchant_id: merchant.id) }
  let!(:item_8) { create(:item, merchant_id: merchant.id) }
  let!(:item_9) { create(:item, merchant_id: merchant_1.id) }

  describe 'Displays a new form to create a new bulk discount' do
    it 'Should display a new form to create a bulk discount, including fields for %discount and quantity' do
      visit new_merchant_bulk_discount_path(merchant)
      
      expect(page).to have_field(:percentage_discount)
      expect(page).to have_field(:quantity_threshold)

      fill_in :percentage_discount, with: 35
      fill_in :quantity_threshold, with: 20
      click_button("Make New Bulk Discount")

      expect(current_path).to eq(merchant_bulk_discounts_path(merchant))

      expect(page).to have_content(35)
      expect(page).to have_content(20)
    end
    
    it 'Should display an error message when some or all fields left blank' do
      visit new_merchant_bulk_discount_path(merchant)

      fill_in :percentage_discount, with: ""
      fill_in :quantity_threshold, with: "1.0"
      click_button("Make New Bulk Discount")

      expect(page).to have_content("ERROR: Please Don't Leave Any Field Blank")
    end
  end
end
