class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.column :title, :string
      t.column :artist, :string
      t.column :album, :string
      t.column :tracknum, :integer
      t.column :genre, :string, :limit=>50
      t.column :comments, :string
      t.column :location, :string
      t.timestamps
    end
  end
end
