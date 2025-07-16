class PostsController < ApplicationController
  before_action :require_login, only: [:index, :create, :recent, :favorites]
  
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
    @posts = current_user.posts.recent.order(created_at: :desc)
  end

  def favorites
    @favorite_posts = current_user.favorite_posts.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:content).merge(user_id: current_user.id)
  end
end
