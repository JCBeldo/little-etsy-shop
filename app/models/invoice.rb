class Invoice < ApplicationRecord
  self.primary_key = :id
  validates :status, presence: true
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  has_many :merchants, through: :items

  enum status: ['cancelled', 'in progress', 'completed']

  def self.invoice_items_not_shipped
    select('invoices.*').joins(:invoice_items).where(invoice_items: {status: ['pending', 'packaged']})
  end

  def format_time_stamp
    created_at.strftime('%A, %B %e, %Y')
  end

  def customer_full_name
  "#{customer.first_name} #{customer.last_name}"
  end

  def total_revenue
    invoice_items.sum("(quantity * unit_price )/ 100.0").round(2).to_s
  end

  def total_discounted_revenue
    inv_it = invoice_items.joins(:bulk_discounts, :merchant)
    .where("invoice_items.quantity >= bulk_discounts.quantity_threshold")
    .select("invoice_items.*, MAX(((invoice_items.quantity * invoice_items.unit_price)/100) - (((invoice_items.quantity * invoice_items.unit_price)/100) * (bulk_discounts.percentage_discount / 100))) AS discounted_revenue")
    .group(:id)
    inv_it.sum(&:discounted_revenue).round(2).to_s
  end
end