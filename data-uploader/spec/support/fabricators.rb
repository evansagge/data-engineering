Fabricator :purchase do
  quantity { (1..20).to_a.sample }
  purchaser { Fabricate(:person) }
  item { Fabricate(:item) }
  merchant { |attr| attr[:item].merchant }
end

Fabricator :person do
  name { Faker::Name.name }
end

Fabricator :merchant do
  name { Faker::Company.name }
  address { Faker::Address.street_address }
end

Fabricator :item do
  description { Faker::Lorem.words((2..5).to_a.sample).join(" ") }
  merchant { Fabricate :merchant }
  price { rand(100) + [0.00, 0.50].sample }
end

Fabricator :record do
end

Fabricator :user do
  provider "openid"
  uid "http://test.myopenid.com"
  name "Test User"
end