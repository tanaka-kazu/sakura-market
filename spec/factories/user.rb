FactoryGirl.define do
  factory :user, :class => User do |user|
    user.nickname 'ニックネーム'
    user.email 'hoge@hoge.com'
    user.password '123456'
    user.role 'member'
  end
end