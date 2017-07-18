class DeliveryInfo < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: { maximum: 120 }
  validates :address, presence: true, length: { maximum: 120 }
end
