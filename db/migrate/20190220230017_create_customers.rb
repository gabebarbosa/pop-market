class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :contact
      t.integer :user_id

      t.timestamps
    end
  end
end
