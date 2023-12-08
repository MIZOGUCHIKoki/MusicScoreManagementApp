# frozen_string_literal: true

class UsersController < ApplicationController
  # %i[ action name ] は method を事前に通過させる
  before_action :signed_in_user, only: %i[index home show edit update destroy]
  before_action :correct_user_admin, only: %i[home show edit update destroy]
  before_action :admin_user, only: %i[index]

  # 一覧を表示：GET
  def index
    @search_params = user_search_params
    @users = User.search(@search_params).paginate(page: params[:page])
  end

  # 個々のデータを表示：GET
  def show
    @user = User.find(params[:id])
    @scores = @user.scores.paginate(page: params[:page])
  end

  # 楽譜一覧
  def home
    redirect_to users_url if current_user.admin

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
    if User.find(params[:id]).admin?
      flash[:danger] = '管理者は削除できません'
      redirect_to user_path(current_user)
    else
      User.find(params[:id]).destroy
      flash[:success] = '削除に成功しました'
      redirect_to users_url, status: :see_other
    end
  end

  private

  def user_params
    # 入力 :user に対して，以下のみを戻す．
    # :name, :email, :password, :password_confirmation
    # "user" => { "name" => "X", "email" => "x@x.com", "password" => "xxxxxx", "password_confirmation" => "xxxxxx" }
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # 正しいユーザか確認する（または管理者であるか確認する）
  def correct_user_admin
    @user = User.find(params[:id])
    redirect_to(signin_path, status: :see_other) unless @user == current_user || current_user.admin?
  end

  # 管理者かどうが確認
  def admin_user
    return if current_user.admin?

    flash[:danger] = '管理者としてサインインしてください'
    redirect_to(signin_path, status: :see_other)
  end

  def user_search_params
    params.fetch(:search, {}).permit(:name, :email)
  end
end
