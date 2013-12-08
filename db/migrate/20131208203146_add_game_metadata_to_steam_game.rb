class AddGameMetadataToSteamGame < ActiveRecord::Migration
  def change
    add_column :steam_games, :release_date, :datetime
    add_column :steam_games, :metacritic_score, :integer
    add_column :steam_games, :metacritic_url, :string
    add_column :steam_games, :app_type, :string
    add_column :steam_games, :detailed_description, :string
    add_column :steam_games, :about_the_game_description, :string
    add_column :steam_games, :supports_windows, :boolean
    add_column :steam_games, :supports_osx, :boolean
    add_column :steam_games, :supports_linux, :boolean
    add_column :steam_games, :last_refresh_date, :timestamp
  end
end
