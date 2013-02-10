class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :title
      t.integer :season
      t.integer :episode_number
      t.integer :episode_in_season
      t.string :production_number
      t.date :airdate
      t.integer :series_id
      t.string :rage_url

      t.timestamps
    end
  end
end
