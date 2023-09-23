class CreateDiscounts < ActiveRecord::Migration[7.0]
  def change
    create_table :discounts do |t|
      t.integer :threshold
      t.float :percentage
      t.references :merchant, foreign_key: true

      t.timestamps
    end
  end
end
