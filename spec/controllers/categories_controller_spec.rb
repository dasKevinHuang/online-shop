require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe "Categories routes" do
    context "index" do
      before(:each) do
        get :index
      end
      it "response with a 200" do
        expect(response.status).to eq(200)
      end
      it "assigns the categories instance variable" do
        expect(assigns(:categories)).to be_a(ActiveRecord::Relation)
      end
    end
    context "show" do
      before(:each) do
        get :show, id: Category.all.first.id
      end
      it "response with a 200" do
        expect(response.status).to eq(200)
      end
      it "assigns the category instance variable" do
        expect(assigns(:category)).to be_a Category      
      end
    end
  end
end
