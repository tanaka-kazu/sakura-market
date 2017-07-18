class Item < ApplicationRecord
#  belongs_to :order_item
  has_attached_file :image,
                    :styles      => { :medium => "300x300>", :thumb => "100x100>" },
                    default_url: "/assets/no-image.png"

  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }
  enum disable_flg: { enable: 0, disable: 1 }
end
