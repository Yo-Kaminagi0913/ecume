class PostsController < ApplicationController
  before_action :require_login
  def index
    @posts = Post.recent.order(created_at: :desc)
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to root_path, notice: "投稿しました"
    else
      flash.now[:alert] = @post.errors.full_messages.to_sentence
      render :new
    end
  end

  def recent
    @posts = Post.recent.order(created_at: :desc)
  end

  def favorites
    @favorite_posts = current_user.favorite_posts.where(expired: false).order(created_at: :desc)
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
