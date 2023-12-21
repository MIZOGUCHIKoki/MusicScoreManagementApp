# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:ex)
    @other = users(:other)
    @other2 = users(:other2)
  end

  # サインインパスを取得できる
  test 'should get new' do
    get signup_path
    assert_response :success
  end

  # 未サインイン状態で home_path を取得せずに signin_path へリダイレクトする
  test 'should get root_path' do
    get home_path(@other)
    assert_response :see_other
    assert_redirected_to signin_path
  end

  # idを持たないhomeを取得できるか
  test 'should call users#home without id' do
    get homeb_path
    assert_response :see_other
    assert_redirected_to signin_path
  end

  # 未サインイン状態でindexを閲覧できない
  test 'should redirect index when not signed in' do
    get users_path
    assert_response :see_other
    assert_redirected_to signin_path
  end

  # サインイン状態でのみ destroy（non-admin） できる
  test 'should redirect destroy when not signed in' do
    assert_no_difference 'User.count' do
      delete user_path(@other)
    end
    assert_response :see_other
    assert_redirected_to signin_path
  end

  # 正常に自分自身のユーザ削除 できる
  test 'should destroy when signed in correct user' do
    sign_in_as(@other)
    assert_difference 'User.count', -1 do
      delete user_path(@other)
    end
    assert_response :see_other
    assert_redirected_to signin_path
  end

  # 管理者は他のユーザを削除できる
  test 'should destroy non-admin users when signed in as admin' do
    sign_in_as(@admin)
    assert_difference 'User.count', -1 do
      delete user_path(@other)
    end
    assert_response :see_other
    assert_redirected_to signin_path
  end

  # 他のユーザによるユーザ削除はできない
  test 'should not destroy a user by other user' do
    sign_in_as(@other)
    assert_no_difference 'User.count' do
      delete user_path(@other2)
    end
    assert_response :see_other
    assert_redirected_to signin_path
  end
end
