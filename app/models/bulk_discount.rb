class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoice_items, through: :items
  validates :percentage_discount, presence: true
  validates :quantity_threshold, length: { minimum: 2 }
end
