class Category < ActiveRecord::Base
  has_many :relationships
  has_many :products, through: :relationships
  validates :title, :description, :image_url, presence: true
end
