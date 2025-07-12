class PostsController < ApplicationController
  before_action :require_login, only: [:create]
  
  def index
    # @posts = Post.recent.order(created_at: :desc)
    @posts = Post.all
    @post = Post.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
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
    params.require(:post).permit(:content).merge(user_id: current_user.id)
  end
end
