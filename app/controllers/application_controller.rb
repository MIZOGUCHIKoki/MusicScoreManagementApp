# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def signed_in_user
    return true if signed_in?

    store_location # ユーザがどこからアクセスしてきたか保存
    # flash[:danger] = 'ログインしてください' # フラッシュメッセージをセット
    # redirect_to controller: :SessionsController, action: :new # ログインページへリダイレクト
    redirect_to signin_path
    false
  end
end
