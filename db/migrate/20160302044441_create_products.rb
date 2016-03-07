class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string    :title
      t.float     :price
      t.text      :details
      t.integer   :quantity
      t.timestamps null: false
    end
  end
end
