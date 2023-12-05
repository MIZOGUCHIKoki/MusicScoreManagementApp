# frozen_string_literal: true

class SessionsController < ApplicationController
  # 新規作成画面を表示：GET（ログイン画面の生成）
  def new; end

  # 作成を実行：POST（ログイン）
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    # sessionハッシュ値のpasswordを取り出す．
    # user（有効なユーザ） && user.authenticate(params[:session][:password])（認証通過）
    if user&.authenticate(params[:session][:password])
      # 認証成功
      reset_session
      sign_in user
      flash[:success] = 'ログインしました'
      redirect_to root_path
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
