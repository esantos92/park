class CreateCars < ActiveRecord::Migration[7.1]
  def change
    create_table :cars do |t|
      t.string :plate, null: false
      t.string :status, null:false
      t.timestamp :check_out

      t.timestamps
    end
  end
end
