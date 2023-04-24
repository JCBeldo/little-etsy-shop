class Merchant::BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.new(bulk_discount_params)
    if bulk_discount.save
      redirect_to merchant_bulk_discounts_path(merchant)
    else
      redirect_to new_merchant_bulk_discount_path(merchant)
      flash[:alert] = "ERROR: Please Don't Leave Any Field Blank"
    end
  end
  
  private
  def bulk_discount_params
    params.permit(:percentage_discount, :quantity_threshold, :merchant_id)
  end
end


