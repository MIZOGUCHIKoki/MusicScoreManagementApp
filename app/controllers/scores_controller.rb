# frozen_string_literal: true

class ScoresController < ApplicationController
  before_action :signed_in_user, only: %i[index show new edit create update destroy]

  # 一覧を表示：GET
  def index; end

  # 個々のデータを表示：GET
  def show
    @score = Score.find(params[:id])
  end

  # 新規作成画面を表示：GET
  def new
    # 管理者ならユーザ一覧へリダイレクト
    return unless current_user.admin

    redirect_to users_url
  end

  # 編集画面を表示：GET
  def edit; end

  # 作成を実行：POST
  def create
    # 管理者ならユーザ一覧へリダイレクト
    return unless current_user.admin

    redirect_to users_url
    @score = current_user.scores.build(score_params)
    if @score.save
      flash[:success] = '登録しました'
      redirect_to user
    else
      flash.now[:danger] = '登録できませんでした'
      render 'new', status: :unprocessable_entity
    end
  end

  # 更新を実行：PATCH/PUT
  def update
    return unless current_user.admin

    redirect_to users_url
  end

  # 削除を実行：DELETE
  def destroy
    score = Score.find(params[:id]).destroy
    flash[:success] = '削除に成功しました'
    redirect_to user_path(id: score.user_id), status: :see_other
  end

  private

  def score_params
    params.require(:score).permit(:name)
  end
end
