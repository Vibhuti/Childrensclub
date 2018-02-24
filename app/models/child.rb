# == Schema Information
#
# Table name: children
#
#  id                      :integer          not null, primary key
#  first_name              :string(255)
#  last_name               :string(255)
#  parent_id               :integer
#  age                     :integer
#  allergies               :string(255)
#  created_at              :datetime
#  updated_at              :datetime
#  user_id                 :integer
#  joining_date            :date
#  leaving_date            :date
#  feedback_requested_date :date
#  dob                     :date
#

class Child < ActiveRecord::Base
  belongs_to :user, :foreign_key => 'user_id'

  validates :user, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :dob, presence: true

end
