class AddFavoritesCountToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :favorites_count, :integer, default: 0, null: false
  end
end
