# frozen_string_literal: true

module SessionsHelper
  # ユーザのログイン処理
  def sign_in(user)
    session[:user_id] = user.id
    session[:user_session_token] = user.session.token
  end

  def remeber(user); end
  def current_user; end
  def forget(user); end

  # ユーザがログインしているか確認
  def sign_in?
    !current_user.nil?
  end

  def sign_out; end
  def current_user?(user); end
  def store_location; end
end
