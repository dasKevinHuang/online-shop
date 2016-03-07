class Product < ActiveRecord::Base
  has_many :relationships
  has_many :categories, through: :relationships
  has_many :order_items
  has_attached_file :photo, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/ 
  validates :title, :quantity, :price, :details, :photo, presence: true
  validates_numericality_of :price, greater_than: 0
  validates_numericality_of :quantity
end
