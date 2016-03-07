class Order < ActiveRecord::Base
  belongs_to :order_status
  belongs_to :user
  has_many :order_items
  validates :subtotal, presence: true
  validates_numericality_of :subtotal, greater_than_or_equal_to: 0
end
