class CreateMovieRoles < ActiveRecord::Migration
  def change
    create_table :movie_roles do |t|
      t.string :name

      t.timestamps
    end
  end
end
