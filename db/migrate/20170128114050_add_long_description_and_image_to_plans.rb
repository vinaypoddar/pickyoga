class AddLongDescriptionAndImageToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :long_description, :text, default: "Enter the long description here.."
    add_column :plans, :image, :text, default: '<img src="/images/img1.jpg" alt="">'
  end
end
