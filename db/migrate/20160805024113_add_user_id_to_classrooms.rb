class AddUserIdToClassrooms < ActiveRecord::Migration
  def change
  	add_column :classrooms, :user_id, :integer
  end
end
