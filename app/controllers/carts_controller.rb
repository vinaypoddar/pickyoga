class CartsController < ApplicationController
  before_filter :authenticate_user!, :only => :show
  
  def show
    @order_items = current_order.order_items
    current_order.update :user => current_user
  end
  
  def update
  end
end
