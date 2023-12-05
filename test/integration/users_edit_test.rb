# frozen_string_literal: true

require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:ex)
    @other = users(:other)
  end

  # 編集に失敗した場合のテスト
  test 'unsuccesssful edit' do
    sign_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: '',
                                              email: 'foo@invalid',
                                              password: 'foo',
                                              password_confirmation: 'bar' } }
    assert_response :unprocessable_entity
    assert_template 'users/edit'
  end

  # 編集に成功した場合のテスト
  test 'successful edit' do
    sign_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = 'Foo Bar'
    email = 'foo@bar.com'
    patch user_path(@user), params: { user: { name:,
                                              email:,
                                              password: '',
                                              password_confirmation: '' } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end

  # 違うユーザを編集ページにアクセスしたとき
  test 'should redirect edit when signed in as wrong user' do
    sign_in_as(@other)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to signin_path
  end

  # 違うユーザを編集しようとしたとき
  test 'should redirect update when signed in as wrong user' do
    sign_in_as(@other)
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert flash.empty?
    assert_redirected_to signin_path
  end

  # 編集ページへアクセスするためにサインインした場合，そのまま編集できるようになる
  test 'successful edit with friendly forwarding' do
    get edit_user_path(@user)
    sign_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    name = 'Foo Bar'
    email = 'foo@bar.com'
    patch user_path(@user), params: { user: { name:,
                                              email:,
                                              password: '',
                                              password_confirmation: '' } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end
