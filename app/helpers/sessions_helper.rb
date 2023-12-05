# frozen_string_literal: true

module SessionsHelper
  # 渡されたユーザでサインインする
  def sign_in(user)
    session[:user_id] = user.id
  end

  # 現在サインイン中のユーザを返す（なければnil）
  def current_user
    return unless session[:user_id] # sessionにuser_idが存在しない場合 return する

    @current_user ||= User.find_by(id: session[:user_id])
  end

  # サインインしているかどうか？
  def signed_in?
    !current_user.nil?
  end

  # サインアウト処理
  def sign_out
    reset_session
    @current_user = nil
  end
end
