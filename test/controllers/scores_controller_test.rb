require "test_helper"

class ScoresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get scores_index_url
    assert_response :success
  end

  test "should get show" do
    get scores_show_url
    assert_response :success
  end

  test "should get new" do
    get scores_new_url
    assert_response :success
  end

  test "should get edit" do
    get scores_edit_url
    assert_response :success
  end

  test "should get createupdate" do
    get scores_createupdate_url
    assert_response :success
  end

  test "should get destroy" do
    get scores_destroy_url
    assert_response :success
  end
end
