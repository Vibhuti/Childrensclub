class AddJoiningDateToChild < ActiveRecord::Migration
  def change
    add_column :children, :joining_date, :date
    add_column :children, :leaving_date, :date
  end
end
