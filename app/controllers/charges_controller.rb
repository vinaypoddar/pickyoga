class ChargesController < ApplicationController
  
  def new
  end
  
  def create
    
    @amount = current_order.amount
    
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )
  
    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => amount.to_i,
      :description => 'Yoga plan purchased',
      :currency    => 'nzd',
      :metadata    => {
        :order_id => current_order.id
      }
    )
    
    current_order.update :status => "Complete"
    
    session[:order_id] = nil
    
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
    
  private
    def amount
      @amount * 100
    end
end
