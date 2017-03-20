class CreateMusics < ActiveRecord::Migration[5.0]
  def change
    create_table :musics do |t|
      t.string  :title

      t.integer :artist_id
      t.integer :album_id
      t.integer :album_artist_id

      t.integer :discnum
      t.integer :tracknum

      t.timestamps
    end
  end
end
