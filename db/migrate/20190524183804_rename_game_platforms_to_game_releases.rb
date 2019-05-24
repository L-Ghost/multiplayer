class RenameGamePlatformsToGameReleases < ActiveRecord::Migration[5.2]
  def change
    #remove_index :game_platforms, :game_platforms
    rename_table :game_platforms, :game_releases
    #add_index :game_releases, :game_releases

    rename_column :events, :game_platform_id, :game_release_id
  end
end
