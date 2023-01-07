class CreateFilms < ActiveRecord::Migration[7.0]
  def change
    create_table :films do |t|
      t.string :imdb_id
      t.string :string
      t.text :title
      t.integer :release_year
      t.string :director
      t.text :summary
      t.string :genre, array:true, default: []
      t.text :image_url
      t.string :location_watched
      t.boolean :seen_before
      t.integer :josh_score
      t.integer :imdb_score
      t.integer :rotten_tom_score
      t.date :date_watched
      t.text :josh_notes
      t.integer :film_length_mins

      t.timestamps
    end
  end
end
