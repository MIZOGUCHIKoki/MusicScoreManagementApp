# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index edit update]
  before_action :correct_user, only: %i[edit update]
  before_action :admin_user, only: %i[index destroy]

  # 一覧の表示 :GET
  def index
    @user = User.all
  end

  # 詳細の表示 :GET
  def show
    @user = User.find(params[:id])
  end

  # 新しいユーザを作るページの表示 :GET
  def new
    @user = User.new
  end

  # ユーザ編集画面の表示
  def edit
    @user = User.find(params[:id])
  end

  # 新しいユーザを作る :POST
  def create
    @user = User.new(user_params) # 実装は終わっていないことに注意!
    if @user.save == true
      # 保存の成功をここで扱う。
      reset_session
      log_in @user
      flash[:success] = 'Welcome!'
      redirect_to @user # userのページにリダイレクト
    else
      render 'new', status: :unprocessable_entity # 保存に失敗した場合
    end
  end

  def update
    @user = User.find(params[:id])
    if @user&.update(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  # ユーザの削除 :DELETE
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to users_url, status: :see_other
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
    return if logged_in?

    flash[:danger] = 'Please login'
    redirect_to login_url, status: :see_other
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url, status: see_other) unless @user == current_user
  end

  def admin_user
    return if current_user.is_admin?

    flash[:danger] = 'Please login as Admin'
    redirect_to(root_url, status: :see_other)
  end
end
