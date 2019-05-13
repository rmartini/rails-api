class CreateBankPeriods < ActiveRecord::Migration[5.0]
  def change
    create_table :bank_periods do |t|
      t.references :bank, foreign_key: true
      t.float :percentage
      t.integer :days
      t.boolean :active

      t.timestamps
    end
  end
end
