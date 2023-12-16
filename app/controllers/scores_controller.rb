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
  def new; end

  # 編集画面を表示：GET
  def edit; end

  # 作成を実行：POST
  def create
    redirect_to users_url if current_user.admin

    # 親モデルに属する子モデルの新たなインスタンス生成に使用：build
    # ユーザに紐づく楽譜情報に新たに足す処理
    @score = current_user.scores.build(score_params)

    if @score.save
      flash[:success] = '新規楽譜の登録が完了しました'
      redirect_to home_path(current_user)
    else
      flash.now[:danger] = '登録できませんでした'
      # renderは"再描画"であるためflashが表示されない．
      redirect_to new_score_path, status: :unprocessable_entity
    end
  end

  # 更新を実行：PATCH/PUT
  def update; end

  # 削除を実行：DELETE
  def destroy; end

  private

  def score_params
    params.require(:score).permit(score: {})
  end
end
