# frozen_string_literal: true

class UsersController < ApplicationController
  # edit, update は signed_in_user/correct_user を事前に通過させる
  before_action :signed_in_user?, only: %i[edit update]
  before_action :correct_user, only: %i[edit update]

  # 一覧を表示：GET
  def index; end

  # 個々のデータを表示：GET
  def show
    @user = User.find(params[:id])
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
      redirect_to scores_path # スコア一覧へ
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
  def destroy; end

  private

  def user_params
    # 入力 :user に対して，以下のみを戻す．
    # :name, :email, :password, :password_confirmation
    # "user" => { "name" => "X", "email" => "x@x.com", "password" => "xxxxxx", "password_confirmation" => "xxxxxx" }
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # サインイン済みのユーザか確認する
  def signed_in_user?
    return true if signed_in?

    # 偽である場合（サインインできていない時）の処理
    store_location # どこからやってきたか保存する
    flash[:danger] = 'サインインしてください'
    redirect_to signin_path, status: :see_other
    false
  end

  # 正しいユーザか確認する
  def correct_user
    @user = User.find(params[:id])
    redirect_to(signin_path, status: :see_other) unless @user == current_user
  end
end
