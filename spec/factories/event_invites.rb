FactoryBot.define do
  factory :event_invite do
    event
    user
    association :invitee, factory: :user
    invite_status { :sent }

    trait :approved do
      invite_status { :approved }
    end
  end
end
