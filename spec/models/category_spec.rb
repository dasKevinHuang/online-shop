require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { Category.new(
    title: 'Test Category 1',
    description: 'This is a description of the category',
    image_url: 'test url')}
    describe 'validations' do
      context 'will raise an error' do
        it 'when the title field is empty' do
          notitle = Category.new(
            description: 'this item has no title',
            image_url: 'test')
            notitle.save
            expect(notitle.errors[:title]).to include("can't be blank")
        end
        it 'when the description field is empty' do
          nodesc = Category.new(
            title: "nodesc",
            image_url: "test")
            nodesc.save
            expect(nodesc.errors[:description]).to include("can't be blank")
        end
        it 'when the image_url field is empty' do
          noimg = Category.new(
            title: "noimg",
            description: "noimg")
            noimg.save
            expect(noimg.errors[:image_url]).to include("can't be blank")
        end
      end
    end

    describe 'category' do
      it 'exists' do
        expect(category).to_not be(nil)
      end
    end


end
