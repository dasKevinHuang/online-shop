class OrderHistoryPdf < Prawn::Document

  def initialize(orders, user)
    super()
    @user = user
    @orders = orders
    cover_page
    @orders.each do |current_order|
      text_content(current_order)
      table_content(current_order)
    end
  end

  def cover_page
    image open("#{Rails.root}/app/assets/images/company_logo.png"), height: 100
    y_position = cursor - 100
    text "Order History for #{@user.email}", size: 15, style: :bold
  end
  
  def text_content(current_order)
    text "\n\n"
    text "Order \##{current_order.id}", size: 15, style: :bold
    text "Customer: #{current_order.user.email}"
    text "Order Date: #{current_order.created_at}"
  end

  def table_content(current_order)
    table product_rows(current_order) do
      row(0).font_style = :bold
      row(0).background_color = "D9EDF7"
      row(-1).background_color = "D9EDF7"
      self.header = true
      self.column_widths = [230, 100, 70, 100]
    end
  end

  def product_rows(current_order)
    [['Product', 'Unit Price', 'Quantity', 'Subtotal']] + current_order.order_items.map do |order|
      [order.product.title, ActionController::Base.helpers.number_to_currency(order.unit_price), order.quantity, ActionController::Base.helpers.number_to_currency(order.quantity * order.unit_price)]
    end + [['','','', ActionController::Base.helpers.number_to_currency(current_order.subtotal)]]
  end

end
