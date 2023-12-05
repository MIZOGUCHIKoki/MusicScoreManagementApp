# frozen_string_literal: true

class UsersController < ApplicationController
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
  def edit; end

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
  def update; end

  # 削除を実行：DELETE
  def destroy; end

  private

  def user_params
    # 入力 :user に対して，以下のみを戻す．
    # :name, :email, :password, :password_confirmation
    # "user" => { "name" => "X", "email" => "x@x.com", "password" => "xxxxxx", "password_confirmation" => "xxxxxx" }
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
