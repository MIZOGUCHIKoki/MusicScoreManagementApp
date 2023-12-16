# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :signed_in_user, only: %i[index home show edit update destroy]
  before_action :correct_user_admin, only: %i[home show edit update destroy]
  before_action :admin_user, only: %i[index]
  # 一覧を表示：GET
  def index
    if current_user.admin # もし管理者なら
      @users = User.all # 全ユーザ情報取得
    else
      render :home # UsersController.homeを呼び出す
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
  def new; end

  # ホーム画面を表示：GET
  def home
    # if params[:input_value] == :order
    #   @user = User.find(params[:id])#ユーザ特定
    #   if params[:order] == 'asc'
    #     order = :grate_sort_asc
    #   elsif params[:order] == 'desc'
    #     order = :grate_sort_desc
    #   else
    #     order = :all
    #   end
    #   @scores = @user.scores.send(order)#ソート結果格納
    # else
    #   @score_params = score_search_params || score_search_gakki_params
    #   if @search_params.instance_of(String)?
    #     @scores = score_search(@search_params)
    #   else
    #     @scores = score_search_gakki(@search_params)
    #   end
    # end
    if params[:input_value] == :order
      @user = User.find(params[:id]) # ユーザ特定
      order = if params[:order] == 'asc' # 昇順
                :grate_sort_asc
              elsif params[:order] == 'desc' # 降順
                :grate_sort_desc
              else
                :all
              end
      @scores = @user.scores.send(order) # ソート結果格納
    elsif params[:input_value] == :name || params[:input_value] == :composer || params[input_value] == :arranger
      @search_params = score_search_params
      @scores = score_search(@search_params)
    else
      @search_params = score_search_gakki_params
      @scores = score_search(@search_params)
    end
  end

  # 編集画面を表示：GET
  def edit; end

  # 作成を実行：POST
  def create
    @user = User.new(user_params)
    if @user.save
      @user.update_sign_in_at
      reset_session
      sign_in @user
      flash[:success] = '登録が完了しました'
      redirect_to @user
    else
      flash[:danger] = '登録に失敗しました'
      # renderは"再描画"であるためflashが表示されない．
      redirect_to new_user_path, status: :unprocessable_entity
    end
  end

  # 更新を実行：PATCH/PUT
  def update; end

  # 削除を実行：DELETE
  def destroy; end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password_digest, :remember_digest)
  end

  def user_search_params
    params.fetch(:user_search, {}).permit(:name, :email)
  end

  def score_search_params
    params.fetch(:score_search, {}).permit(:name, :composer, :arranger, :grade)
  end

  def current_user_admin
    @user = User.find(params[:id])
  raise ActiveRecord::RecordNotFound unless @user == current_user || current_user.admin?
rescue ActiveRecord::RecordNotFound
  redirect_to signin_path, status: :see_other
  end
  def admin_user
    raise '管理者としてサインインしてください' unless current_user.admin?
  rescue StandardError => e
    flash[:danger] = e.message
    redirect_to signin_path, status: :see_other
  end
end
