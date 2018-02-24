# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  title      :string(255)
#  content    :text
#  user_id    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  parent_id  :integer
#

class Message < ActiveRecord::Base
end
