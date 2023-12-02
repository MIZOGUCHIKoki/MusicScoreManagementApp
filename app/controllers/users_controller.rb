# frozen_string_literal: true

class UsersController < ApplicationController
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
  def edit; end

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

  # ユーザの削除 :DELETE
  def destroy; end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
