require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  context "associations" do
    it "belongs to product" do
      reflect = OrderItem.reflect_on_association(:product)
      expect(reflect.macro).to eq :belongs_to
    end
    it "belongs to order" do
      reflect = OrderItem.reflect_on_association(:order)
      p reflect
      expect(reflect.macro).to eq :belongs_to
    end
  end
end
