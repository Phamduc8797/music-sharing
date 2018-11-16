class CreateLyrics < ActiveRecord::Migration[5.2]
  def change
    create_table :lyrics do |t|
      t.text :content
      t.boolean :accepted, default: false
      t.references :user, foreign_key: true
      t.references :song, foreign_key: true
      t.timestamps
    end
  end
end
