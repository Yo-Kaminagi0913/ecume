class FavoritesController < ApplicationController
  before_action :require_login
  def create
    post = Post.find(params[:post_id])
    current_user.favorites.find_or_create_by!(post: post)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    fav = current_user.favorites.find_by(post_id: params[:post_id])
    fav&.destroy
    redirect_back(fallback_location: root_path)
  end
end
