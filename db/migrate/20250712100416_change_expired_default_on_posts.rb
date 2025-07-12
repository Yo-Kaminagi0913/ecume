class ChangeExpiredDefaultOnPosts < ActiveRecord::Migration[7.1]
  def change
    change_column_default :posts, :expired, from: nil, to: false
  end
end