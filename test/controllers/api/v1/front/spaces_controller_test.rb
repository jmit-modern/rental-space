require "test_helper"

class Api::V1::Front::SpacesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_v1_front_space = api_v1_front_spaces(:one)
  end

  test "should get index" do
    get api_v1_front_spaces_url
    assert_response :success
  end

  test "should get new" do
    get new_api_v1_front_space_url
    assert_response :success
  end

  test "should create api_v1_front_space" do
    assert_difference('Api::V1::Front::Space.count') do
      post api_v1_front_spaces_url, params: { api_v1_front_space: {  } }
    end

    assert_redirected_to api_v1_front_space_url(Api::V1::Front::Space.last)
  end

  test "should show api_v1_front_space" do
    get api_v1_front_space_url(@api_v1_front_space)
    assert_response :success
  end

  test "should get edit" do
    get edit_api_v1_front_space_url(@api_v1_front_space)
    assert_response :success
  end

  test "should update api_v1_front_space" do
    patch api_v1_front_space_url(@api_v1_front_space), params: { api_v1_front_space: {  } }
    assert_redirected_to api_v1_front_space_url(@api_v1_front_space)
  end

  test "should destroy api_v1_front_space" do
    assert_difference('Api::V1::Front::Space.count', -1) do
      delete api_v1_front_space_url(@api_v1_front_space)
    end

    assert_redirected_to api_v1_front_spaces_url
  end
end
