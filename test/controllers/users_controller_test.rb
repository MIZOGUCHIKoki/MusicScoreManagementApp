# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get login page' do
    get login_path
    assert_response :success
  end
end
