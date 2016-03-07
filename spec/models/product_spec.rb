require 'rails_helper'

RSpec.describe Product, type: :model do

  let(:product_no_title) { Product.new(
    details: 'test details',
    price: 12.99,
    quantity: 12,
    photo_file_name: "test_nuts.jpg",
    photo_content_type: 'image/jpg'
    )}

  let(:product_no_detail) { Product.new(
    title: 'test title',
    price: 12.99,
    quantity: 12,
    photo_file_name: "test_nuts.jpg",
    photo_content_type: 'image/jpg'
    )}

  let(:product_no_price) { Product.new(
    details: 'test details',
    title: 'test title',
    quantity: 12,
    photo_file_name: "test_nuts.jpg",
    photo_content_type: 'image/jpg'
    )}

  let(:product_no_quantity) { Product.new(
    details: 'test details',
    title: 'test title',
    price: 12.99,
    photo_file_name: "test_nuts.jpg",
    photo_content_type: 'image/jpg'
    )}

  let(:product_invalid_quantity) { Product.new(
    details: 'test details',
    title: 'test title',
    price: 12.99,
    quantity: 'aa',
    photo_file_name: "test_nuts.jpg",
    photo_content_type: 'image/jpg'
    )}

  let(:product_valid) { Product.new(
    details: 'test details',
    title: 'test title',
    price: 12.99,
    quantity: 21,
    photo_file_name: "test_nuts.jpg",
    photo_content_type: 'image/jpg'
    )}

  let(:product_no_photo) { Product.new(
    details: 'test details',
    title: 'test title',
    price: 12.99,
    quantity: 21
    )}

  let(:product_invalid_content_type) { Product.new(
    details: 'test details',
    title: 'test title',
    price: 12.99,
    quantity: 21,
    photo_file_name: "test_nuts.jpg",
    photo_content_type: 'application/pdf'
    )}

  describe 'validations' do
    context 'will raise an error ' do
      it 'when the title field is empty' do
      product_no_title.save
      expect(product_no_title.errors[:title]).to include("can't be blank")
      end

      it 'when the detail field is empty' do
      product_no_detail.save
      expect(product_no_detail.errors[:details]).to include("can't be blank")
      end

      it 'when the price field is empty' do
      product_no_price.save
      expect(product_no_price.errors[:price]).to include("can't be blank")
      end

      it 'when the quantity field is empty' do
      product_no_quantity.save
      expect(product_no_quantity.errors[:quantity]).to include("can't be blank")
      end

      it 'when the photo field is empty' do
      product_no_photo.save
      expect(product_no_photo.errors[:photo]).to include("can't be blank")
      end

      it 'when the quantity field is not numeric' do
      product_invalid_quantity.save
      expect(product_invalid_quantity.errors[:quantity]).to include("is not a number")
      end

      it 'when the photo content type is invalid' do
      product_invalid_content_type.save
      expect(product_invalid_content_type.errors[:photo_content_type]).to include("is invalid")
      end
    end
    context 'will save with no errors' do
      it 'when all fields are valid' do
      expect{ product_valid.save }.to change{Product.count}.by(1)
      end


    end
  end
end
