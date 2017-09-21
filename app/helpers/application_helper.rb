module ApplicationHelper
  def cart_count
    if current_user.present?
      current_user.cart_items.count('id')
    else
      session[:cart].try(:keys).try(:size).to_i
    end 
  end
end
