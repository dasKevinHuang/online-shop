require 'rails_helper'

RSpec.describe Admin, type: :model do

  let(:admin){ Admin.delete_all
  
  password = "timtim"
  new_hashed_password = Admin.new(:password => password).encrypted_password

  admin = Admin.create(
    email:    "tim@tim.com",
    encrypted_password: new_hashed_password
    )}
    
    describe "admin exists" do
      it "will not be nil" do
        expect(admin).to_not be(nil)
      end
    end
end
