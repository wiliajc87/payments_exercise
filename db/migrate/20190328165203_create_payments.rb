class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.belongs_to :loan, foreign_key: true, null: false, index: true
      t.decimal :amount, precision: 8, scale: 2, null: false

      t.timestamps null: false
    end
  end
end
