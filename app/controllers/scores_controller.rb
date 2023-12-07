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
    redirect_to users_url if current_user.admin

    @score = Score.new
  end

  # 編集画面を表示：GET
  def edit
    redirect_to users_url if current_user.admin
    @score = Score.find(params[:id])
  end

  # 作成を実行：POST
  def create
    # 管理者ならユーザ一覧へリダイレクト
    redirect_to users_url if current_user.admin

    @score = current_user.scores.build(score_params)
    if @score.save
      flash[:success] = '登録しました'
      redirect_to home_path(current_user)
    else
      flash.now[:danger] = '登録できませんでした'
      render 'new', status: :unprocessable_entity
    end
  end

  # 更新を実行：PATCH/PUT
  def update
    # redirect_to users_url if current_user.admin

    @score = Score.find(params[:id])
    if @score.update(score_params)
      flash[:success] = '更新しました'
      redirect_to score_url(@score)
    else
      render 'edit', status: :unprocessable_entity
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
    params.require(:score).permit(:name)
  end
end
