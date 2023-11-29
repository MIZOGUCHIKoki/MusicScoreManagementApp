# frozen_string_literal: true

require 'test_helper'

class ScoresControllerTest < ActionDispatch::IntegrationTest
  test 'should get index page' do
    get scores_path
    assert_response :success
  end
end
