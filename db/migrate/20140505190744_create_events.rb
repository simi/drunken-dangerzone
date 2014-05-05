class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :month_id
      t.date :day_id
      t.string :name
      t.datetime :date
      t.string :place
      t.integer :attending, default: 0, null: false
      t.integer :weekly
      t.integer :biweekly
      t.integer :parent_id

      t.timestamps
    end
  end
end
