FactoryBot.define do
  factory :event do
    sequence(:title) { |i| "Evento #{i}" }
    user
    game_platform
    description { (0...30).map { ('a'..'z').to_a[rand(26)] }.join }
    event_date { Time.zone.now + 3.days }
    user_limit { rand(5..10) }
    event_type { 1 }
    event_location { 'MyString' }
  end
end
