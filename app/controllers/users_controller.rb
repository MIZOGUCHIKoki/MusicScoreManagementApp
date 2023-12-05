# frozen_string_literal: true

class UsersController < ApplicationController
  # edit, update は signed_in_user/correct_user を事前に通過させる
  before_action :signed_in_user, only: %i[index edit update destroy]
  before_action :correct_user, only: %i[edit update]
  before_action :admin_user, only: %i[index destroy]

  # 一覧を表示：GET
  def index
    @users = User.paginate(page: params[:page])
  end

  # 個々のデータを表示：GET
  def show
    @user = User.find(params[:id])
    @scores = @user.scores.paginate(page: params[:page])
  end

  # 新規作成画面を表示：GET
  def new
    @user = User.new
  end

  # 編集画面を表示：GET
  def edit
    @user = User.find(params[:id])
  end

  # 作成を実行：POST
  def create
    # @user = User.new(params[:user])
    # 上記はセキュリティ的な問題があるので user_params を使って，特定のparamsのみを引き渡す
    @user = User.new(user_params)
    if @user.save
      reset_session
      sign_in @user
      flash[:success] = '登録が完了しました'
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end

  # 更新を実行：PATCH/PUT
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = '保存に成功しました'
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  # 削除を実行：DELETE
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = '削除に成功しました'
    redirect_to users_url, status: :see_other
  end

  private

  def user_params
    # 入力 :user に対して，以下のみを戻す．
    # :name, :email, :password, :password_confirmation
    # "user" => { "name" => "X", "email" => "x@x.com", "password" => "xxxxxx", "password_confirmation" => "xxxxxx" }
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # 正しいユーザか確認する
  def correct_user
    @user = User.find(params[:id])
    redirect_to(signin_path, status: :see_other) unless @user == current_user
  end

  # 管理者かどうが確認
  def admin_user
    return if current_user.admin?

    flash[:danger] = '管理者としてサインインしてください'
    redirect_to(signin_path, status: :see_other)
  end
end
