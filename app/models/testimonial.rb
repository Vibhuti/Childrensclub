# == Schema Information
#
# Table name: testimonials
#
#  id         :integer          not null, primary key
#  entry      :text
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Testimonial < ActiveRecord::Base
  validate :entry, :presence => true
  belongs_to :user
end
