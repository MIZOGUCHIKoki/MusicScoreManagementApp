# frozen_string_literal: true

module SessionsHelper
  # ユーザのログイン処理
  def sign_in(user)
    session[:user_id] = user.id
    session[:user_session_token] = user.session.token
  end

  def remeber(user); end
  
  #現在のuserを取得
  def current_user; 
    if (user_id = session[:user_id])
      user = User.find_by(id: user_id)
      user if user && sessin[:sessin_token] == user.sessin_token
    elsif (user_id cokkies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if (user && user.authenticated?(cookies[:remember_token]))
        sign_in user
        user
      end
    end
  end
  
  def forget(user); end

  # ユーザがログインしているか確認
  def sign_in?
    !current_user.nil?
  end

  def sign_out; end
  def current_user?(user); 
    user && user == current_user
  end
  def store_location; end
end
