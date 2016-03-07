class PostmanWorker
  include Sidekiq::Worker
  def perform(h, count)
    h = JSON.load(h)
    UserMailer.contact_email(h['email']).deliver
  end
end
