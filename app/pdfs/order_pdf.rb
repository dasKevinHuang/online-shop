class OrderPdf < Prawn::Document

  def initialize(order)
    super()
    @order = order
    header
    text_content
    table_content
  end

  def header
    image open("#{Rails.root}/app/assets/images/company_logo.png"), height: 100
  end
  def text_content
    y_position = cursor - 100
    text "Order \##{@order.id}", size: 15, style: :bold
    text "Customer: #{@order.user.email}"
    text "Order Date: #{@order.created_at}"
  end

  def table_content
    table product_rows do
      row(0).font_style = :bold
      row(0).background_color = "D9EDF7"
      row(-1).background_color = "D9EDF7"
      self.header = true
      self.column_widths = [230, 100, 70, 100]
    end
  end

  def product_rows
    [['Product', 'Unit Price', 'Quantity', 'Subtotal']] + @order.order_items.map do |order|
      [order.product.title, ActionController::Base.helpers.number_to_currency(order.unit_price), order.quantity, ActionController::Base.helpers.number_to_currency(order.quantity * order.unit_price)]
    end + [['','','', ActionController::Base.helpers.number_to_currency(@order.subtotal)]]
  end
end
