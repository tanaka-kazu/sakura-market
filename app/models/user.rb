class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :delivery_info
  has_many :order
  enum role: { admin: 1, member: 2 }
  validates :nickname, length: { maximum: 120 }
end
