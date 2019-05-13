class CreateOperations < ActiveRecord::Migration[5.0]
  def change
    create_table :operations do |t|
      t.references :bank_period, foreign_key: true
      t.float :amount
      t.float :profit
      t.float :percentage

      t.timestamps
    end
  end
end
