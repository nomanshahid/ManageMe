class AddEmployeraddrColumnToKids < ActiveRecord::Migration
  def change
    add_column :kids, :gaurdian_one_employer_addr, :string
    add_column :kids, :gaurdian_two_employer_addr, :string
  end
end
