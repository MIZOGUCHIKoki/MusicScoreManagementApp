# frozen_string_literal: true

require 'test_helper'

class ScoresControllerTest < ActionDispatch::IntegrationTest
  def setup
    @score = scores(:maba)
  end

  # 未サインインの状態で作成できないか
  # test 'should redirect create when not signed in' do
  #   assert_no_difference 'Score.count' do
  #     post scores_path, params: { score: { name: '眩い' } }
  #   end
  #   assert_redirected_to signin_path
  # end

  #   # 未サインインの状態で削除できないか
  #   test 'should redirect destroy when not signed in' do
  #     assert_no_difference 'Score.count' do
  #       delete score_path(@score)
  #     end
  #     assert_response :see_other
  #     assert_redirected_to signin_path
  #   end
end
