require 'rails_helper'

RSpec.describe 'Merchant/bulk_discount index page', type: :feature do
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

  describe 'displays bulk discounts and their attributes' do
    let!(:bulk_discount_1) { merchant.bulk_discounts.create!(percentage_discount: 15, quantity_threshold: 10, merchant_id: merchant.id) }
    let!(:bulk_discount_2) { merchant.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 15, merchant_id: merchant.id) }
    let!(:bulk_discount_3) { merchant_1.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10, merchant_id: merchant_1.id) }
 
    it 'should display the bulk discounts the deiscount in a percentage, and the quantity threshold' do
      visit merchant_bulk_discounts_path(merchant)
      
      expect(page).to have_content(bulk_discount_1.percentage_discount)
      expect(page).to have_content(bulk_discount_1.quantity_threshold)
      expect(page).to have_content(bulk_discount_1.id)
    end

    it 'should display a link to the show page via the id' do
      visit merchant_bulk_discounts_path(merchant)
      
      expect(page).to have_link(bulk_discount_1.id)
      expect(page).to have_link(bulk_discount_2.id)
      expect(page).to_not have_link(bulk_discount_3.id)
    
      visit merchant_bulk_discounts_path(merchant_1)

      expect(page).to have_link(bulk_discount_3.id)
      expect(page).to_not have_link(bulk_discount_1.id)
      expect(page).to_not have_link(bulk_discount_2.id)
    end
  end
  
  describe 'Displays a link to create a new bulk discount' do
    it 'should display a new link to create a new discount and redirect to a new page' do
      visit merchant_bulk_discounts_path(merchant)
      
      expect(page).to have_link("Create New Discount")

      click_link("Create New Discount")

      expect(current_path).to eq(new_merchant_bulk_discount_path(merchant))
    end
  end

  describe 'Displays a button to delete an exisitng bulk discount' do
    let!(:bulk_discount_1) { merchant.bulk_discounts.create!(percentage_discount: 15, quantity_threshold: 10, merchant_id: merchant.id) }
    let!(:bulk_discount_2) { merchant.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 15, merchant_id: merchant.id) }
    let!(:bulk_discount_3) { merchant_1.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10, merchant_id: merchant_1.id) }

    it 'should display a button to delete a bulk discount' do
      visit merchant_bulk_discounts_path(merchant)
      save_and_open_page
      expect(page).to have_content(bulk_discount_1.id)
      expect(page).to have_content(bulk_discount_2.id)
      expect(page).to have_button("Delete Bulk Discount #{bulk_discount_1.id}")

      click_button("Delete Bulk Discount #{bulk_discount_1.id}")
      
      expect(current_path).to eq(merchant_bulk_discounts_path(merchant))
      expect(page).to_not have_content(bulk_discount_1.id)
      expect(page).to have_content(bulk_discount_2.id)
    end
  end
end

# As a merchant
# When I visit my bulk discounts index
# Then next to each bulk discount I see a link to delete it
# When I click this link
# Then I am redirected back to the bulk discounts index page
# And I no longer see the discount listed