# frozen_string_literal: true

require 'test_helper'

class UsersSignin < ActionDispatch::IntegrationTest
  def setup
    @user = users(:ex)
    @other = users(:other)
  end
end

class InvalidPasswordTest < UsersSignin
  test 'signin path' do
    get signin_path # signin_path でページを取得できたか
    assert_template 'sessions/new' # sessions/new が呼び出されたか
  end

  # 無効なパスワードで認証する
  test 'sign-in with invalid password' do
    post signin_path, params: { session: { email: @user.email, password: 'invalid' } } # Emailとパスワードを代入
    assert_response :unprocessable_entity # 422レスポンスか
    assert_template 'sessions/new' # session/newが呼び出されたか
    assert_not flash.empty?
    get signin_path
    assert flash.empty?
  end
end

class ValidSigninTest < UsersSignin
  # 管理者として
  test 'redirect after signin as admin' do
    post signin_path, params: { session: { email: @user.email, password: 'password' } }
    assert signed_in?
    assert_redirected_to users_path
    follow_redirect! # リダイレクトを実行
    assert_template 'users/index'
    assert_select 'a[href=?]', signin_path, count: 0
    assert_select 'a[href=?]', signout_path, count: 1
    assert_select 'a[href=?]', users_path, count: 1
    delete signout_path
    assert_not signed_in?
    assert_response :see_other # 303レスポンス
    assert_redirected_to signin_path
    follow_redirect!
    assert_select 'a[href=?]', signin_path, count: 1
    assert_select 'a[href=?]', signout_path, count: 0
    assert_select 'a[href=?]', users_path, count: 0
    assert_select 'a[href=?]', user_path(@other), count: 0
  end

  # 管理者でないとして
  test 'redirect after signin as non-admin' do
    post signin_path, params: { session: { email: @other.email, password: 'password' } }
    assert_redirected_to home_path(@other)
    follow_redirect! # リダイレクトを実行
    assert_template 'users/home'
    assert_select 'a[href=?]', signin_path, count: 0
    assert_select 'a[href=?]', signout_path, count: 1
    assert_select 'a[href=?]', home_path(@other), count: 1
    delete signout_path
    assert_not signed_in?
    assert_response :see_other # 303レスポンス
    assert_redirected_to signin_path
    follow_redirect!
    assert_select 'a[href=?]', signin_path, count: 1
    assert_select 'a[href=?]', signout_path, count: 0
    assert_select 'a[href=?]', users_path, count: 0
    assert_select 'a[href=?]', user_path(@other), count: 0
  end
end

class RememberingTest < UsersSignin
  # サインイン情報を記録するテスト
  test 'sign-in with remembering' do
    sign_in_as(@user, remember_me: '1')
    assert_not cookies[:remember_token].blank?
  end

  # サインイン情報を記録しないテスト
  test 'sing-in without remembering' do
    # Cookieを保存してサインイン
    sign_in_as(@user, remember_me: '1')
    # Cookieを削除して再サインイン
    sign_in_as(@user, remember_me: '0')
    assert cookies[:remember_token].blank?
  end
end
