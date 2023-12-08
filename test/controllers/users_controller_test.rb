# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:ex)
    @other = users(:other)
  end

  test 'should get new' do
    get signup_path
    assert_response :success
  end

  # 未サインイン状態でルートを取得できるか
  test 'should get root_path' do
    get root_path
    assert_response :see_other
    assert_redirected_to signin_path
  end

  # サインイン状態でのみ index をみれるか
  test 'should redirect index when not signed in' do
    get users_path
    assert_redirected_to signin_path
  end

  # サインイン状態でのみ destroy（non-admin） できるか
  test 'should redirect destroy when not signed in' do
    assert_no_difference 'User.count' do
      delete user_path(@other)
    end
    assert_response :see_other
    assert_redirected_to signin_path
  end

  # adminアカウントのみ destroy（non-admin） できるか
  test 'should redirect destroy when signed in as a non-admin' do
    sign_in_as(@other)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_response :see_other
    assert_redirected_to signin_path
  end
end
