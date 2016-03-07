class OrderWorker
  include Sidekiq::Worker
  def perform(h, count)
    h = JSON.load(h)
    UserMailer.order_email(h['email'], h['order_id']).deliver_now
  end
end
