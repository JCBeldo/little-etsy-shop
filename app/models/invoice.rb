class Invoice < ApplicationRecord
  self.primary_key = :id
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
end