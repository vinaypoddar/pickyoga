class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :title
      t.text :description, default: "Enter the description here.."
      t.float :price

      t.timestamps null: false
    end
  end
end
