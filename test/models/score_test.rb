# frozen_string_literal: true

require 'test_helper'

class ScoreTest < ActiveSupport::TestCase
  def setup
    @user = users(:other)
    # @score = Score.new(name: '眩い星座になるために', user_id: @user.id)
    @score = @user.scores.build(name: '眩い星座になるために')
  end

  test 'should be valid' do
    assert @score.valid?
  end

  test 'user id should be present' do
    @score.user_id = nil
    assert_not @score.valid?
  end

  test 'name/etc.. should be present' do
    @score.name = ' '
    assert_not @score.valid?
  end

  test 'name/etc.. should be at most 50 characters' do
    @score.name = 'a' * 51
    assert_not @score.valid?
  end
end
