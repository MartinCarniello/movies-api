FactoryBot.define do
  factory :movie do
    title { Faker::Lorem.word }
    release_year { Faker::Date.between(50.years.ago, Date.today).year }
  end
end