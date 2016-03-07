require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe "welcome email" do
    before(:each) do
      @email = UserMailer.contact_email("kevin@kevin.com")
    end
    it "creates a mailer" do
      expect(@email).to_not be(nil)
    end
    it "sends the mailer" do
      @email.deliver_now
      expect(UserMailer.deliveries.empty?).to_not be(true)
    end
    it "sends to the correct recipient" do
      expect(@email.to).to eq(["kevin@kevin.com"])
    end
    it "sends from the correct shop email address" do
      expect(@email.from).to eq(["#{ENV['gmail_username']}"])
    end
    it "sends with the correct subject" do
      expect(@email.subject).to eq('Welcome to our shop!')
    end
  end
end
