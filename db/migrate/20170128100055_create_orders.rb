class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user
      t.decimal :amount, precision: 12, scale: 3

      t.timestamps null: false
    end
  end
end
