require 'rails_helper'

RSpec.describe Order, type: :model do
  context "associations" do
    it "belong to user" do
      t = Order.reflect_on_association(:user)
      expect(t.macro).to eq :belongs_to
    end 
    it "belongs to order_status" do
      t = Order.reflect_on_association(:order_status)
      expect(t.macro).to eq :belongs_to
    end
    it "has many order_items" do
      t = Order.reflect_on_association(:order_items)
      expect(t.macro).to eq :has_many
    end
  end
  context "validations" do
    it "invalid if blank" do
      order = Order.new
      order.save
      expect(order.errors[:subtotal]).to include("can't be blank")
    end
    it "invalid if less than 0" do
      order = Order.new(subtotal: -5)
      order.save
      expect(order.errors[:subtotal]).to include("must be greater than or equal to 0")
    end
  end
end
