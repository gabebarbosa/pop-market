class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.integer :amount
      t.integer :user_id

      t.timestamps
    end
  end
end
