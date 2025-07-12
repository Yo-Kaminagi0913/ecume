class FavoritesController < ApplicationController
  before_action :require_login
  before_action :set_post

  def create
    current_user.favorite(@post)

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.turbo_stream
    end
  end

  def destroy
    current_user.unfavorite(@post)

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.turbo_stream
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end