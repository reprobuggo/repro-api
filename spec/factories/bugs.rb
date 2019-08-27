FactoryBot.define do
  factory :bug do
    title { Faker::Lorem.word }
    created_by { Faker::Number.number(digits: 10) }
  end
end
