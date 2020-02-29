class CreateDiscounts < ActiveRecord::Migration[5.1]
  def change
    create_table :discounts do |t|
      t.string :name
      t.string :description
      t.decimal :discount_amt
      t.integer :req_qty
      t.references :merchant, foreign_key: true
    end
  end
end
