class RenameCategoryGamesToGameCategorizations < ActiveRecord::Migration[5.2]
  def change
    rename_table :category_games, :game_categorizations
  end
end
