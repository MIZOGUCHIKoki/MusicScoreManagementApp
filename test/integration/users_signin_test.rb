# frozen_string_literal: true

require 'test_helper'

class UsersSigninTest < ActionDispatch::IntegrationTest
  test 'signin with invalid information' do
    get signin_path # signin_path でページを取得できたか
    assert_template 'sessions/new' # sessions/new が呼び出されたか
    post signin_path, params: { session: { email: '', password: '' } } # Emailとパスワードを代入
    assert_response :unprocessable_entity # 422レスポンスか
    assert_template 'sessions/new' # session/newが呼び出されたか
    assert_not flash.empty?
    get signin_path
    assert flash.empty?
  end
end
