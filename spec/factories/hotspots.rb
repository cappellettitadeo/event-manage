# frozen_string_literal: true

FactoryBot.define do
  factory :hotspot do
    association(:event)
    destination_url { Faker::Internet.url(scheme: 'https') }

    after(:create) do |hotspot|
      hotspot.update!(external_id: hotspot.id.to_s)
    end
  end
end
