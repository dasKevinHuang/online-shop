require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake! # fake is the default mode
RSpec.describe PostmanWorker, type: :worker do 
  before(:each) {
    Sidekiq::Worker.clear_all
  }
  describe "Postman worker" do
    it "creates a new job" do
      expect{
        PostmanWorker.perform_async("{email: 'kevin@kevin.com}", 5)}.to change(PostmanWorker.jobs, :size).by(1)
    end
  end
end
