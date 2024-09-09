class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.string :status
      t.references :car, null: false, foreign_key: true

      t.timestamps
    end
  end
end
