# frozen_string_literal: true

class ScoresController < ApplicationController
  before_action :signed_in_user, only: %i[index show new edit create update destroy]

  # 一覧を表示：GET
  def index; end

  # 個々のデータを表示：GET
  def show; end

  # 新規作成画面を表示：GET
  def new; end

  # 編集画面を表示：GET
  def edit; end

  # 作成を実行：POST
  def create
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
  def update; end

  # 削除を実行：DELETE
  def destroy; end

  private

  def score_params
    params.require(:score).permit(:name)
  end
end
