# frozen_string_literal: true

module SessionsHelper
  # 渡されたユーザでサインインする
  def sign_in(user)
    session[:user_id] = user.id
    # セッションリプレイ攻撃から保護する
    session[:session_token] = user.session_token
    # サインイン時刻を記録する
    user.update_sign_in_at
  end

  # 永続的セッションのためにユーザをデータベースに記憶する
  def remember(user)
    user.remember # :remember_digest に保存する
    # cookies[:remember_token] = { value: remmber_token,
    #                              expires: 20.years.from_now.utc }
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # 現在サインイン中のユーザを返す（なければnil）
  def current_user
    # セッションがあれば
    if (user_id = session[:user_id]) # 代入した後にuser_idが存在すれば真
      user = User.find_by(id: user_id)
      # @current_user = @current_user || User.find_by(id: session[:user_id])
      # @current_user ||= User.find_by(id: session[:user_id]) <helperからインスタンス変数を削除>
      User.find_by(id: session[:user_id]) if user && session[:session_token] == user.session_token
    # Cookieに情報があれば
    elsif (user_id = cookies.encrypted[:user_id]) # 代入した後にuser_idが存在すれば真
      # raise # 例外処理を強制する（Passしたら未通過）
      user = User.find_by(id: user_id)
      # Cookiesの内容を認証する
      # if user && user.authenticated?(cookies[:remember_token])
      if user&.authenticated?(cookies[:remember_token])
        # Cookiesに情報があればサインインする
        sign_in user
        # @current_user = user # <helperからインスタンス変数を削除>
        user
      end
    end
  end

  # Cookieの情報を削除する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # サインインしているかどうか？
  def signed_in?
    !current_user.nil?
  end

  # サインアウト処理
  def sign_out
    forget current_user
    reset_session
    # @current_user = nil <helperからインスタンス変数を削除>
  end

  # 渡されたユーザが現在のユーザであれば true を返す
  def current_user?(user)
    user && user == current_user
  end

  # アクセスしようとしたURLを保存する
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
