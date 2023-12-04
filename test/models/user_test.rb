# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'MIZOGUCHI Koki', email: 'user@example.com')
  end

  # ユーザが有効かどうか
  test 'should be valid' do
    assert @user.valid?
  end

  # ユーザの名前が空白の場合，無効かどうか
  test 'name should be persent' do
    @user.name = '    '
    assert_not @user.valid?
  end

  # emailの名前が空白の場合，無効かどうか
  test 'email should be persent' do
    @user.email = '    '
    assert_not @user.valid?
  end

  # 名前の最大長が50以下であるか
  test 'name should not be too long' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  # emailの最大長が255以下であるか
  test 'email should not be too long' do
    @user.email = "#{'a' * 244}@example.com"
    assert_not @user.valid?
  end
end
