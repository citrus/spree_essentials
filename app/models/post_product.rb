class PostProduct < ActiveRecord::Base

  belongs_to :post
  belongs_to :product

  validates_associated :post
  validates_associated :product

end