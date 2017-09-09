class CreateAbsents < ActiveRecord::Migration
  def change
    create_table :absents do |t|
      t.date :date

      t.timestamps null: false
    end
  end
end
