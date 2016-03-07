require 'rails_helper'

RSpec.describe Relationship, type: :model do

  describe "relationship validations" do
    it "should belong to a product" do
      expect(Relationship.all.first.product).to be_a Product
    end
    it "should belong to a category" do
      expect(Relationship.all.first.category).to be_a Category
    end
  end
end
