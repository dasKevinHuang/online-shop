class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = OrderPdf.new(@order)
        send_data pdf.render, filename: 'order.pdf', type: 'application/pdf'
      end
    end
  end

  def index
    @orders = current_user.orders
    respond_to do |format|
      format.html
      format.pdf do
        pdf = OrderHistoryPdf.new(@orders, current_user)
        send_data pdf.render, filename: "orderhistory.pdf", type: 'application/pdf'
      end
    end
  end

end
