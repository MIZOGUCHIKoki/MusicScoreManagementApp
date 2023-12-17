# frozen_string_literal: true

module SessionsHelper
  # ユーザのログイン処理
  def sign_in(user)
    session[:user_id] = user.id
    session[:user_session_token] = user.session.token
  end

  def remeber(user)
    user.remember # :remember_digest に保存する
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # 現在のuserを取得
  def current_user
    if (user_id = session[:user_id])
      user = User.find_by(id: user_id)
      user if user && session[:session_token] == user.session_token
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user&.authenticated?(cookies[:remember_token])
        sign_in user
        user
      end
    end
  end

  def forget(user)
    user.forget
    cookies[:user_id] = nil
    cookies[:remember_token] = nil
  end

  # ユーザがログインしているか確認
  def signed_in?
    !current_user.nil?
  end

  def sign_out
    forget current_user
    reset_session
  end

  def current_user?(user)
    user && user == current_user
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
