class StaticController < ApplicationController


  before_action :authenticate_admin!, only: [:admin]


  def info
    @categories = Category.all
  end

  def empty_cart
    session.delete(:cart_items)
    if request.xhr?
      render partial: '/static/shopping_cart', layout: false
    else
      redirect_to '/cart'
    end
  end

  def update_cart
    if user_signed_in? == false
      flash[:alert] =  "You need to sign in in order to make a purchase"
      redirect_to '/cart'

    elsif params[:commit] == 'Complete Order'
      @order = Order.new
      @order.subtotal = 0
      @order.user = current_user

      @order.save
      @order_items = OrderItem.new

      params[:product].each do |k,v|

        @order_items = OrderItem.new
        @product = Product.find(k)

        @order_items.product_id = @product.id
        @order_items.order_id = @order.id
        @order_items.unit_price = @product.price
        @order_items.quantity = v.to_i
        @order_items.product.quantity -= v.to_i
        @order_items.product.save
        @order_items.total_price = v.to_i * @product.price
        @order.subtotal += v.to_i * @product.price
        @order_items.save
        @order.save
        h = JSON.generate({'email' => current_user.email, 'order_id' => @order.id })
        OrderWorker.perform_async(h, 5)
      end
      session.delete(:cart_items)
      redirect_to order_path(@order.id)
    else
      params[:product].each do |k,v|
        @product = Product.find(k)
        if @product.quantity > v.to_i
          session[:cart_items][k] = v
          flash[:success] =  "Cart quantities are updated"
        else
          flash[:alert] =  "Order quantity of #{v} can not exceed stock quantity of #{@product.quantity}"
        end
      end
      redirect_to '/cart'
    end
  end

  def add_to_cart

    @product = Product.find(params[:id])

    if @product.quantity < params[:q].to_i
      redirect_to product_path(@product), flash: { alert: "Order quantity of #{params[:q]} can not exceed stock quantity of #{@product.quantity}" }    
    else
      unless session[:cart_items]
        session[:cart_items] = Hash.new
      end
      session[:cart_items][params[:id]] = params[:q]
      redirect_to '/cart'
    end    
  end

  def remove_from_cart
    session[:cart_items].delete(params[:id])

    if request.xhr?
      render partial: '/static/shopping_cart', layout: false
    else
      redirect_to '/cart'
    end

  end

  def admin
    @products = Product.all.order('created_at DESC')
  end

end
