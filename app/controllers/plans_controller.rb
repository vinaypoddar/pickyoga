class PlansController < ApplicationController
  def index
    @plans = Plan.all.order(:id)
    puts "this is vinay " + @plans.inspect
    @plan = Plan.new
    @order_item = current_order.order_items.new
  end
  
  def create
    puts "this is vinay inside created"
    puts params.inspect
    @plan = Plan.new(:title => params[:plan][:title], :price => params[:plan][:price])
    puts "this is vinay inside create after plan"
    respond_to do |format|
      if @plan.save
        format.html { redirect_to @plan, notice: 'Plan was successfully created.' }
        format.json { render action: 'show', status: :created, location: @plan }
        # added:
        format.js   { render action: 'show', status: :created, location: @plan }
      else
        format.html { render action: 'new' }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
        # added:
        format.js   { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def mercury_update
    plan = Plan.find(params[:id])
    plan.image = params[:content]['plan_image_'+ params[:id]][:value]
    plan.title = params[:content]['plan_title_'+ params[:id]][:value]
    plan.description = params[:content]['plan_description_'+ params[:id]][:value]
    plan.long_description = params[:content]['plan_long_description_'+ params[:id]][:value]
    plan.price = params[:content]['plan_price_'+ params[:id]][:value]
    plan.save!
    render text: ""
  end
  
  def show
    @plan = Plan.find(params[:id])
  end
  
  def destroy
    if Plan.find(params[:id]).destroy!
      redirect_to "/plans"
    else
      render :index
    end
  end
end
