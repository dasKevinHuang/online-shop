require 'rails_helper'
RSpec.describe Devise::SessionsController, :type => :controller do
    login_user
  context 'Can sign in as an user' do

    it "should have a current_user" do
      # note the fact that you should remove the "validate_session" parameter if this was a scaffold-generated controller
      expect(controller.current_user).to_not eq(nil)
    end
  end
  context 'going to log out route' do
    it 'should log out current user' do
      delete :destroy
      expect(response.status).to eq(302)
      expect(controller.current_user).to eq(nil)
    end
  end
  context 'Going to sign in page as a non-user' do
    it "should get sign in page" do
      # Note, rails 3.x scaffolding may add lines like get :index, {}, valid_session
      # the valid_session overrides the devise login. Remove the valid_session from your specs
      delete :destroy
      get :new
      expect(response.status).to eq(200)
    end
  end
end
