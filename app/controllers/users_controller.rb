# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :signed_in_user, only: %i[index home show edit update destroy]
  before_action :correct_user_admin, only: %i[home show edit update destroy]
  before_action :admin_user, only: %i[index]
  # 一覧を表示：GET
  def index; end

  # 個々のデータを表示：GET
  def show; end

  # 新規作成画面を表示：GET
  def new; end

  # ホーム画面を表示：GET
  def home; end

  # 編集画面を表示：GET
  def edit; end

  # 作成を実行：POST
  def create; end

  # 更新を実行：PATCH/PUT
  def update; end

  # 削除を実行：DELETE
  def destroy; end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def user_search_params
    params.fetch(:user_search, {}).permit(:name, :email)
  end

  def current_user_admin; end
  def admin_user; end
end
