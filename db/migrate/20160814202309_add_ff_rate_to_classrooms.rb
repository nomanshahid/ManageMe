class AddFfRateToClassrooms < ActiveRecord::Migration
  def change
    add_column :classrooms, :ffrate, :string
  end
end
