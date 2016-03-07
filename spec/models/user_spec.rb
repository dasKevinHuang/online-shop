require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user){ User.delete_all
  
  password = "timtim"
  new_hashed_password = User.new(:password => password).encrypted_password

  user = User.create(
    email:    "tim@tim.com",
    encrypted_password: new_hashed_password
    )}
    
    describe "user exists" do
      it "will not be nil" do
        expect(user).to_not be(nil)
      end
    end
end
