class Video < ActiveRecord::Base

  def self.public_videos
    Video.all.where(:public => true)
  end
end
