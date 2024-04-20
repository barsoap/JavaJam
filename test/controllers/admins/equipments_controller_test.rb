require "test_helper"

class Admins::EquipmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admins_equipments_index_url
    assert_response :success
  end

  test "should get show" do
    get admins_equipments_show_url
    assert_response :success
  end

  test "should get destroy" do
    get admins_equipments_destroy_url
    assert_response :success
  end
end
