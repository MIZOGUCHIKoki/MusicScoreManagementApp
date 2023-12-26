# frozen_string_literal: true

require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  # 'signin_path' でページを取得できるか
  test 'should get new' do
    get signin_path
    assert_response :success
  end
end
