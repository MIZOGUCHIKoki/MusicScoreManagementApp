# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :signed_in_user, only: %i[index home show edit update destroy]
  before_action :correct_user_admin, only: %i[home show edit update destroy]
  before_action :admin_user, only: %i[index]
  # 一覧を表示：GET
  def index
    if current_user.admin?
      @search_params = user_search_params
      @users = User.user_search(@search_params)
    else
      redirect_to controller: :SessionsController, action: :new
    end
  end

  # 個々のデータを表示：GET
  def show
    @user = if current_user.admin?
              User.find(params[:id])
            else
              User.find(current_user.id)
            end
  end

  # 新規作成画面を表示：GET
  def new
    @user = User.new
  end

  # ホーム画面を表示：GET
  # @user = User.find(params[:id]) # ユーザ特定
  # @scores = @user.scores.all
  #  if params.key?(:order)

  #    order = if params[:order] == 'asc' # 昇順
  #              :grate_sort_asc
  #            elsif params[:order] == 'desc' # 降順
  #              :grate_sort_desc
  #            else
  #              :all
  #            end
  #    @scores = @user.scores.send(order) # ソート結果格納
  #  elsif params.key?(:name) || params.key?(:composer) || params.key?(:arranger)

  # @score_params = score_search_params # score_search_paramsは検索ボックスの入力値取得メソッド
  # @scores = Score.score_search(@score_params) # score_serchによりDBから内容取得

  #  elsif !params[:use_gakki].nil?
  #    @score_params = score_search_gakki_params
  #    @scores = User.score_search_gakki(@score_params)
  #  else
  #   @scores = @user.scores.all
  #  end
  def home
    @user = User.find(params[:id]) # ユーザ特定

    @score_params = score_search_params

    case params[:order]
    when 'asc'
      return @scores = @user.scores.grade_sort_asc
    when 'desc'
      return @scores = @user.scores.grade_sort_desc
    when '通常'
      return @scores = @user.scores.grade_sort_no
    end
    # 検索ボックスへの入力があるかどうかを確認
    if @score_params[:name].present? || @score_params[:composer].present? || @score_params[:arranger].present?

      return @scores = @user.scores.score_search(@score_params)
    end

    @score_params = score_search_gakki_params
    return @scores = @user.scores.score_search_gakki(@score_params) if @score_params.present?

    @scores = @user.scores.all
  end

  # def search_box_has_input?
  #   # 検索ボックスに入力があるかどうかを確認するメソッド
  #   !@score_params[:name].blank?
  # end

  # 編集画面を表示：GET
  def edit
    @user = User.find(params[:id])
  end

  # 作成を実行：POST
  def create
    @user = User.new(user_params)
    if @user.save
      @user.update_sign_in_at
      reset_session
      sign_in @user
      flash[:success] = '登録が完了しました'
      redirect_to home_path(@user)
    else
      flash.now[:danger] = '登録に失敗しました'
      # renderは"再描画"であるためflashが表示されない．
      render :new, status: :unprocessable_entity
    end
  end

  # 更新を実行：PATCH/PUT
  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = '変更が完了しました'
      redirect_to @user
    else
      flash.now[:danger] = '変更に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  # 削除を実行：DELETE
  def destroy
    if User.find(params[:id]).admin?
      flash[:danger] = '管理者は削除できません'
      redirect_to user_path(current_user)
    elsif current_user.admin?
      User.find(params[:id]).destroy
      flash[:success] = '削除に成功しました'
      redirect_to action: :index, status: :see_other
    else
      User.find(params[:id]).destroy
      flash[:success] = '削除に成功しました'
      redirect_to signin_path, status: :see_other
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_search_params
    params.fetch(:user_search, {}).permit(:name, :email)
  end

  def score_search_params
    params.fetch(:score_search, {}).permit(:name, :composer, :arranger, :grade)
  end

  def score_search_gakki_params
    params.fetch(:score_search_gakki, {}).permit(:piccolo, :c_flute,
                                                 :oboe, :english_horn, :b_clarinet, :e_clarinet,
                                                 :b_bass_clarinet, :bassoon, :e_alto_saxophone,
                                                 :b_tenor_saxophone, :b_baritone_saxophone,
                                                 :b_trumpet, :f_horn, :trombone, :euphonium,
                                                 :tuba, :string_bass, :eb,
                                                 :piano, :harp, :timpani, :drums, :percussion)
  end

  def correct_user_admin
    @user = User.find(params[:id])
    raise ActiveRecord::RecordNotFound unless @user == current_user || current_user.admin?
  rescue ActiveRecord::RecordNotFound
    redirect_to signin_path, status: :see_other
  end

  def admin_user
    raise '管理者としてサインインしてください' unless current_user&.admin?
  rescue StandardError => e
    flash[:danger] = e.message
    redirect_to signin_path, status: :see_other
  end
end
