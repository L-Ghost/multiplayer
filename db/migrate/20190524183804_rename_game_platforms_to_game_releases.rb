class RenameGamePlatformsToGameReleases < ActiveRecord::Migration[5.2]
  def change
    rename_table :game_platforms, :game_releases

    rename_column :events, :game_platform_id, :game_release_id
  end
end
