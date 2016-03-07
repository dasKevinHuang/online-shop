require 'rails_helper'

describe ProductsController do
  let(:product) { FactoryGirl.create :product}
  let(:attributes) { FactoryGirl.attributes_for :product}

  describe "GET products" do
    before(:each) do
      get :index
    end
    it "responds with a 200" do
      expect(response.status).to eq(200)
    end
    it "assigns the products instance variable" do
      expect(assigns(:products)).to be_a(ActiveRecord::Relation)
    end
  end
  describe "GET #new" do
    before(:each) do
      get :new
    end
    it "responds with a 200" do
      expect(response.status).to eq(200)
    end
  end

  describe "GET #edit" do
    before(:each) do
      get :edit, id: product.id
    end
    it "responds with a 200" do
      expect(response.status).to eq(200)
    end
  end
 # describe 'POST #create' do
 #   it "saves a new product in the database" do
 #     expect{
 #       post :create, :product => attributes}.to change{ Product.count}.by(1)
 #   end
 #   it "redirects to product path" do
 #     post :create, :product => attributes
 #     expect(response.status).to eq(302)
 #   end 
 # end

  describe 'GET #show' do
    before(:each) do
      get :show, id: product.id
    end
    it "assigns the product instance variable" do
      expect(assigns(:product)).to be_a(Product)
    end
  end

  describe 'PUT #update' do
    let!(:title) { "A new product title." }
    it 'updates a field on product' do
      put :update, id: product.id, product: {
        title: title,
        details: 'test details',
        price: 12.99,
        quantity: 12
      }
      expect(product.reload.title).to eq(product.title)
    end
  end
  describe 'DELETE #destroy' do
    it 'decrements products by one' do
      product_id = product.id
      expect {
        delete :destroy, id: product_id
      }.to change{ Product.count }.by(-1)
    end
    it 'redirects to the root path' do
      product_id = product.id
      delete :destroy, id: product_id
      expect(response.status).to eq(302)
    end
  end

end
