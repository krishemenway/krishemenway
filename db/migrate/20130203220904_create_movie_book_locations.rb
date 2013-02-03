class CreateMovieBookLocations < ActiveRecord::Migration
  def change
    create_table :movie_book_locations do |t|
      t.integer :movie_id
      t.integer :book_id
      t.integer :page_id

      t.timestamps
    end
  end
end
