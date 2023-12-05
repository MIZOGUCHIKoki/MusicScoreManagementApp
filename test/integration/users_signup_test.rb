# frozen_string_literal: true

require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # 無効なデータに対してsignupを検査する
  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: '',
                                         email: 'user@invalid',
                                         password: 'foo',
                                         password_confirmation: 'bar' } }
    end
    assert_response :unprocessable_entity
    assert_template 'users/new'
  end

  # 有効なデータに対してsignupを検査する
  test 'valid signup information' do
    get signup_path
    assert_difference 'User.count' do
      post users_path, params: { user: { name: 'test',
                                         email: 'user@valid.com',
                                         password: 'foofoo',
                                         password_confirmation: 'foofoo' } }
    end
    assert_response :redirect
    assert_redirected_to scores_path
    follow_redirect!
    assert_template 'scores/index'
    assert_not flash.empty?
    get scores_path
    assert flash.empty?
  end
end
