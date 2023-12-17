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
    redirect_to users_url if current_user.admin
  end

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
  def update
    # 編集される楽譜のユーザと現在のユーザが同じか確かめる（current_user = いじりたい楽譜データの持ち主）
    @score = Score.find(params[:id])
    if @score.update(score_params)
      flash[:success] = '変更が完了しました'
      # 設計書に間違いあり(index -> user.home)
      redirect_to home_path(current_user)
    else
      flash[:danger] = '変更に失敗しました'
      redirect_to edit_score_path, status: :unprocessable_entity
    end
  end

  # 削除を実行：DELETE
  def destroy
    Score.find(params[:id]).destroy
    flash[:success] = '削除に成功しました'
    redirect_to home_path(current_user), status: :see_other
  end

  private

  def score_params
    params.require(:score).permit(score: {})
  end
end
