class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.boolean :public
      t.string :youtube_video

      t.timestamps
    end
  end
end
