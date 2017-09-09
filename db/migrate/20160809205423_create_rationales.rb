class CreateRationales < ActiveRecord::Migration
  def change
    create_table :rationales do |t|

      t.timestamps null: false
    end
  end
end
