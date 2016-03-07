require 'rails_helper'
RSpec.describe Users::RegistrationsController, :type => :controller do
  before(:each) { @request.env["devise.mapping"] = Devise.mappings[:user]}

  context 'registration page' do
    it 'should display the registration form' do
      get :new
      expect(response.status).to eq(200)
    end
  end

end

