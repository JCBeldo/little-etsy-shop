require 'rails_helper'

RSpec.describe 'Merchant/bulk_discount show page', type: :feature do
  let!(:merchant) { create(:merchant) }
  let!(:merchant_1) { create(:merchant) }
  let!(:bulk_discount_1) { merchant.bulk_discounts.create!(percentage_discount: 15, quantity_threshold: 10, merchant_id: merchant.id) }
  let!(:bulk_discount_2) { merchant.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 15, merchant_id: merchant.id) }
  let!(:bulk_discount_3) { merchant_1.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10, merchant_id: merchant_1.id) }
  
  describe 'displays the bulk discounts attributes' do
    it 'should display the percentage discount and quantity threshold of a particular bulk discount' do
      visit merchant_bulk_discount_path(merchant, bulk_discount_1)

      expect(page).to have_content(bulk_discount_1.percentage_discount)
      expect(page).to have_content(bulk_discount_1.quantity_threshold)
      
      visit merchant_bulk_discount_path(merchant_1, bulk_discount_3)
      
      expect(page).to have_content(bulk_discount_3.percentage_discount)
      expect(page).to have_content(bulk_discount_3.quantity_threshold)
    end
  end

  describe 'displays a link to edit the bulk discount' do
    it 'should display a link to go to an edit page to update the bulk discount' do
      visit merchant_bulk_discount_path(merchant, bulk_discount_1)
      
      expect(page).to have_link("Edit Bulk Discount")

      click_link("Edit Bulk Discount")

      expect(current_path).to eq(edit_merchant_bulk_discount_path(merchant, bulk_discount_1))
    end
  end
end
