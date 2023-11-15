# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: 'user@example.com',
                     name: 'KUT Windbrass',
                     password: 'password',
                     password_confirmation: 'password')
  end

  test 'should be valid' do # 入力が正しく保存されているか？
    assert @user.valid?
  end

  test 'email addresses should be unique' do # emailが一意なものであるか？
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid? # 同じものを代入して
  end

  test 'name should be present' do # 名前が空文字の場合，無効であるか？
    @user.name = ' '
    assert_not @user.valid?
  end

  test 'password should be present' do # パスワードが空文字の場合，無効であるか？
    @user.password = ' '
    assert_not @user.valid?
  end

  test 'password should be persent (non blank)' do
    @user.password = @user.password_confirmation = ' ' * 8
    assert_not @user.valid?
  end

  test 'password should have a minimum length' do
    @user.password = @user.password_confirmation = 'a' * 6
    assert_not @user.valid?
  end

  test 'email validation should reject invalid addresses' do # メールフォーマットが正しいか？
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost:)
  end
end
