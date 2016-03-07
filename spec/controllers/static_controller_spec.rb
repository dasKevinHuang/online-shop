require 'rails_helper'

RSpec.describe StaticController, type: :controller do
  login_admin
  describe "Static routes" do
    context "info" do
      before(:each) do
        get :info
      end
      it "response with a 200" do
        expect(response.status).to eq(200)
      end
      it "assigns the categories instance variable" do
        expect(assigns(:categories)).to be_a(ActiveRecord::Relation)
      end
    end
    context "admin" do
      before(:each) do
        get :admin
      end
      it "response with a 200" do
        expect(response.status).to eq(200)
      end
      it "assigns the products instance variable" do
        expect(assigns(:products)).to be_a(ActiveRecord::Relation)
      end
    end
    context "empty_cart" do
      it 'deletes cart of the current session' do
        session[:cart_items] = "Cart Placeholder"
        expect { delete :empty_cart }.to change{ session[:cart_items]}
      end
      it 'redirects to root path' do
        delete :empty_cart
        expect(response.status).to eq(302)
      end
    end
  end
end
