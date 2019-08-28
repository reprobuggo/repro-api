FactoryBot.define do
  factory :step do
    name { Faker::Movies::StarWars.character }
    done false
    bug_id nil
  end
end
