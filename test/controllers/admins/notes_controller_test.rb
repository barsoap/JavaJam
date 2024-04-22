require "test_helper"

class Admins::NotesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admins_notes_index_url
    assert_response :success
  end

  test "should get show" do
    get admins_notes_show_url
    assert_response :success
  end

  test "should get destroy" do
    get admins_notes_destroy_url
    assert_response :success
  end
end
