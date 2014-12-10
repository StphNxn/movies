class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :year
      t.date :release_date
      t.string :genre
      t.text :poster_url
      t.text :plot
      t.integer :runtime
      t.integer :oscars
      t.string :imdbid

      t.timestamps
    end
  end
end
