# frozen_string_literal: true

class SessionsController < ApplicationController
  # 新規作成画面を表示：GET（サインイン画面の生成）
  def new
    return unless signed_in?

    if current_user.admin?
      redirect_to users_path
    else
      redirect_to home_path(current_user)
    end
  end

  # 作成を実行：POST（サインイン）
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    # sessionハッシュ値のpasswordを取り出す．
    # user（有効なユーザ） && user.authenticate(params[:session][:password])（認証通過）
    if user&.authenticate(params[:session][:password])
      # 認証成功
      forwarding_url = session[:forwarding_url]
      reset_session
      # 条件式 ? 真の式 : 偽の式
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      sign_in user
      if current_user.admin?
        redirect_to forwarding_url || users_path
      else
        redirect_to forwarding_url || home_path(user)
      end
    else
      # 認証失敗
      flash.now[:danger] = 'Eメール・パスワードが異なります'
      render 'new', status: :unprocessable_entity
    end
  end

  # 削除を実行：DELETE（ログアウト）
  def destroy
    sign_out
    redirect_to signin_path, status: :see_other # 303レスポンス
  end
end
