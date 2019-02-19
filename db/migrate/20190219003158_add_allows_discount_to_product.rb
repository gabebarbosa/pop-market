class AddAllowsDiscountToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :allows_discount, :boolean, :default => false
  end
end
