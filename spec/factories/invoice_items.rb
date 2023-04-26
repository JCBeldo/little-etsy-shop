FactoryBot.define do
  factory :invoice_item do
    quantity { rand(0..50)}
    unit_price { rand(1000..100000)}
    status { rand(0..2)}
  end
end