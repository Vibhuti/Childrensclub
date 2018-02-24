class CreateTestimonials < ActiveRecord::Migration
  def change
    create_table :testimonials do |t|
      t.text :entry
      t.integer :user_id

      t.timestamps
    end
  end
end
