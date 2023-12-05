# frozen_string_literal: true

require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
  def setup
    @user = users(:ex)
    remember(@user)
  end

  # current_user が正く返ってきているか（ログイン中のセッションにおいて）
  test 'current_user returns right user when session is nil' do
    assert_equal @user, current_user
    assert signed_in?
  end

  # current_user がnilになるか（remember digestが）
  test 'current_user returns nil when remember digest is wrong' do
    # 新しい :remember_digest を代入する
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user # current_userで処理を通す
  end
end
