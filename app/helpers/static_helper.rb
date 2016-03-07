module StaticHelper

  def cart_total
    if session[:cart_items]
      return session[:cart_items].length
    else
      return 0
    end
  end

end
