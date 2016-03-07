class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.decimal :subtotal, precision: 12, scale: 3
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
