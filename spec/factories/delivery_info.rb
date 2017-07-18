FactoryGirl.define do
  factory :delivery, :class => DeliveryInfo do |delivery|
    delivery.name 'テストユーザー'
    delivery.address 'テスト住所'
    association :user, factory: :user
  end
  factory :empty_delivery, :class => DeliveryInfo do |delivery|
    association :user, factory: :user
  end
end