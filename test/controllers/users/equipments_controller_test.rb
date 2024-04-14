require "test_helper"

class Users::EquipmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get users_equipments_new_url
    assert_response :success
  end

  test "should get index" do
    get users_equipments_index_url
    assert_response :success
  end

  test "should get show" do
    get users_equipments_show_url
    assert_response :success
  end

  test "should get edit" do
    get users_equipments_edit_url
    assert_response :success
  end
end
