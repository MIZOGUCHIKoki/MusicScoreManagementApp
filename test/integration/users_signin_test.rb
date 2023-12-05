# frozen_string_literal: true

require 'test_helper'

class UsersSigninTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:ex)
  end
  # 無効な情報で認証する
  test 'sign-in with invalid information' do
    get signin_path # signin_path でページを取得できたか
    assert_template 'sessions/new' # sessions/new が呼び出されたか
    post signin_path, params: { session: { email: '', password: '' } } # Emailとパスワードを代入
    assert_response :unprocessable_entity # 422レスポンスか
    assert_template 'sessions/new' # session/newが呼び出されたか
    assert_not flash.empty?
    get signin_path
    assert flash.empty?
  end

  # 間違いであるパスワードで認証する
  test 'sign-in with valid email / invalid password' do
    get signin_path
    assert_template 'sessions/new'
    post signin_path, params: { session: { email: @user.email, password: 'invalid' } }
    assert_not signed_in?
    assert_response :unprocessable_entity
    assert_template 'sessions/new'
    assert_not flash.empty?
    get signin_path
    assert flash.empty?
  end

  # 正しい情報で認証する
  test 'sign-in with valid information followed by sign-out' do
    post signin_path, params: { session: { email: @user.email, password: 'password' } }
    assert signed_in?
    assert_redirected_to root_path
    follow_redirect! # リダイレクトを実行
    assert_template 'scores/index'
    assert_select 'a[href=?]', signin_path, count: 0
    assert_select 'a[href=?]', signout_path, count: 1
    assert_select 'a[href=?]', user_path(@user), count: 1
    delete signout_path
    assert_not signed_in?
    assert_response :see_other # 303レスポンス
    assert_redirected_to signin_path
    follow_redirect!
    assert_select 'a[href=?]', signin_path, count: 1
    assert_select 'a[href=?]', signout_path, count: 0
    assert_select 'a[href=?]', user_path(@user), count: 0
  end
end
