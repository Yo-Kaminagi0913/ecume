class UsersController < ApplicationController
  # サインアップフォーム
  def new
    @user = User.new
  end

  # サインアップ処理
  def create
    @user = User.new(user_params)
    if @user.save
      # 作成と同時にログインさせる
      session[:user_id] = @user.id
      redirect_to root_path, notice: "アカウントを作成し、ログインしました"
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  # マイページ
  def show
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :name)
  end
end