FactoryBot.define do
  factory :idea do
    description { FFaker::Lorem.sentence }
    author { FFaker::Name.unique.name }
  end
end
