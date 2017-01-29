class AddOrderNumberInOrders < ActiveRecord::Migration
  def change
    add_column :orders, :order_number, :string
  end
end
