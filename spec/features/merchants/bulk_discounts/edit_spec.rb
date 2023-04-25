require 'rails_helper'

RSpec.describe 'Merchant/bulk_discount edit page', type: :feature do
  let!(:merchant) { create(:merchant) }
  let!(:merchant_1) { create(:merchant) }
  let!(:bulk_discount_1) { merchant.bulk_discounts.create!(percentage_discount: 15, quantity_threshold: 10, merchant_id: merchant.id) }
  let!(:bulk_discount_2) { merchant.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 15, merchant_id: merchant.id) }
  let!(:bulk_discount_3) { merchant_1.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10, merchant_id: merchant_1.id) }
  
  describe 'displays a form to edit an exisiting bulk discount' do
    it 'should display a pre-populated form from an exisiting BD' do
      visit edit_merchant_bulk_discount_path(merchant, bulk_discount_1)

      expect(page).to have_field("Percentage discount"), with: 15.0
      expect(page).to have_field("Quantity threshold"), with: 10
    end

    it "should have editable field and should go back to show page when updated" do
      visit edit_merchant_bulk_discount_path(merchant, bulk_discount_1)

      fill_in "Percentage discount", with: "2.5"
      fill_in "Quantity threshold", with: "12"
      click_button("Update Bulk Discount")

      expect(current_path).to eq(merchant_bulk_discount_path(merchant, bulk_discount_1))
      
      expect(page).to have_content("Percentage off: %2.5")
      expect(page).to have_content("Number of items to qualify for discount: 12")
    end
  end
end