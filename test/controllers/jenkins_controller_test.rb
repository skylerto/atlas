require 'test_helper'

class JenkinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @jenkin = jenkins(:one)
  end

  test "should get index" do
    get jenkins_url
    assert_response :success
  end

  test "should get new" do
    get new_jenkin_url
    assert_response :success
  end

  test "should create jenkin" do
    assert_difference('Jenkin.count') do
      post jenkins_url, params: { jenkin: { password: @jenkin.password, server_ip: @jenkin.server_ip, username: @jenkin.username } }
    end

    assert_redirected_to jenkin_url(Jenkin.last)
  end

  test "should show jenkin" do
    get jenkin_url(@jenkin)
    assert_response :success
  end

  test "should get edit" do
    get edit_jenkin_url(@jenkin)
    assert_response :success
  end

  test "should update jenkin" do
    patch jenkin_url(@jenkin), params: { jenkin: { password: @jenkin.password, server_ip: @jenkin.server_ip, username: @jenkin.username } }
    assert_redirected_to jenkin_url(@jenkin)
  end

  test "should destroy jenkin" do
    assert_difference('Jenkin.count', -1) do
      delete jenkin_url(@jenkin)
    end

    assert_redirected_to jenkins_url
  end
end
