FactoryBot.define do
  factory :bulk_discount do
    percentage_discount { 1.5 }
    quantity_threshold { 1 }
    merchant { nil }
  end
end
