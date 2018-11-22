class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos do |t|
      t.string :link
      t.string :uid
      t.integer :likes
      t.integer :dislikes
      t.datetime :published_at

      t.timestamps
    end
    add_index :videos, :uid
  end
end
