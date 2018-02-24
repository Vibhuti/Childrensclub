class AddDobToChild < ActiveRecord::Migration
  def change
    add_column :children, :dob, :date
  end
end
