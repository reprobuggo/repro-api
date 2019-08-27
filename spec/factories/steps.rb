FactoryBot.define do
  factory :step do
    name { Faker::StarWars.character }
    done false
    bug_id nil
  end
end
