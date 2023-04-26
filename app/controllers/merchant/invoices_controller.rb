class Merchant::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
    @merchant = Merchant.find(params[:merchant_id])
  end
  
  def show
    @invoice = Invoice.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
    # @bulk_discount = BulkDiscount.find_by(params[:bulk_discount_id])
  end
end