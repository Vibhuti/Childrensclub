class AddFeedbackRequestedDateToChild < ActiveRecord::Migration
  def change
    add_column :children, :feedback_requested_date, :date
  end
end
