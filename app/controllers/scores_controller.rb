# frozen_string_literal: true

class ScoresController < ApplicationController
  before_action :signed_in_user, only: %i[index show new edit create update destroy]
  before_action :private_url, only: %i[show edit] # url直接入力における閲覧・編集の禁止
  # 一覧を表示：GET
  def index; end

  # 個々のデータを表示：GET
  def show
    # @score = Score.find(params[:id])
  end

  # 新規作成画面を表示：GET
  def new
    redirect_to users_url if current_user.admin
    @score = Score.new
  end

  # 編集画面を表示：GET
  def edit
    redirect_to users_url if current_user.admin
    # @score = Score.find(params[:id])
  end

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
      render :new, status: :unprocessable_entity
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
      flash.now[:danger] = '変更に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  # 削除を実行：DELETE
  def destroy
    Score.find(params[:id]).destroy
    flash[:success] = '削除に成功しました'
    if current_user.admin?
      redirect_to controller: :users, action: :index, status: :see_other
    else
      redirect_to home_path(current_user), status: :see_other
    end
  end

  private

  def score_params
    params.require(:score).permit(:name, :composer, :arranger,
                                  :grade, :m_time, :piccolo, :c_flute,
                                  :oboe, :english_horn, :b_clarinet, :e_clarinet,
                                  :b_bass_clarinet, :bassoon, :e_alto_saxophone,
                                  :b_tenor_saxophone, :b_baritone_saxophone,
                                  :b_trumpet, :f_horn, :trombone, :euphonium,
                                  :tuba, :string_bass, :eb,
                                  :piano, :harp, :timpani, :drums, :percussion)
  end

  def private_url
    @score = Score.find(params[:id])
    return unless !current_user.admin? && @score.user_id != current_user.id

    redirect_to home_path(current_user)
  end
end
