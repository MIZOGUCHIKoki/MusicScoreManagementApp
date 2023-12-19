# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :signed_in_user, only: %i[index home show edit update destroy]
  before_action :correct_user_admin, only: %i[home show edit update destroy]
  before_action :admin_user, only: %i[index]
  # 一覧を表示：GET
  # def index
  #   if current_user.admin # もし管理者なら
  #     @users = User.all # 全ユーザ情報取得
  #   else
  #     render :home # UsersController.homeを呼び出す
  #   end
  # end
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
    elsif params[:input_value] == :name || params[:input_value] == :composer || params[:input_value] == :arranger
      @search_params = score_search_params
      @scores = score_search(@search_params)
    elsif !params[:use_gakki].nil?
      @search_params = score_search_gakki_params
      @scores = score_search_gakki(@search_params)
    end
  end

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
      redirect_to @user
    else
      flash.now[:danger] = '登録に失敗しました'
      # renderは"再描画"であるためflashが表示されない．
      render :new, status: :unprocessable_entity
    end
  end

  # 更新を実行：PATCH/PUT
  def update
    @user = User.find(params[:id])

    return unless correct_user_admin

    if @user.update(user_params)
      flash[:success] = '変更が完了しました'
      redirect_to @user
    else
      falsh[:danger] = '変更に失敗しました'
      redirect_to edit_user_path, status: :unprocessable_entity
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
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_search_params
    params.fetch(:user_search, {}).permit(:name, :email)
  end

  def score_search_params
    params.fetch(:score_search, {}).permit(:name, :composer, :arranger, :grade)
  end

  def score_search_gakki_params
    params.permit(use_gakki: [])
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
