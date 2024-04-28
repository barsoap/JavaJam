require "test_helper"

class Users::NotesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get users_notes_new_url
    assert_response :success
  end

  test "should get index" do
    get users_notes_index_url
    assert_response :success
  end

  test "should get show" do
    get users_notes_show_url
    assert_response :success
  end

  test "should get edit" do
    get users_notes_edit_url
    assert_response :success
  end
end
