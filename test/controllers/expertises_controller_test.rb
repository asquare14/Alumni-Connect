require 'test_helper'

class ExpertisesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @expertise = expertises(:one)
  end

  test "should get index" do
    get expertises_url
    assert_response :success
  end

  test "should get new" do
    get new_expertise_url
    assert_response :success
  end

  test "should create expertise" do
    assert_difference('Expertise.count') do
      post expertises_url, params: { expertise: { name: @expertise.name } }
    end

    assert_redirected_to expertise_url(Expertise.last)
  end

  test "should show expertise" do
    get expertise_url(@expertise)
    assert_response :success
  end

  test "should get edit" do
    get edit_expertise_url(@expertise)
    assert_response :success
  end

  test "should update expertise" do
    patch expertise_url(@expertise), params: { expertise: { name: @expertise.name } }
    assert_redirected_to expertise_url(@expertise)
  end

  test "should destroy expertise" do
    assert_difference('Expertise.count', -1) do
      delete expertise_url(@expertise)
    end

    assert_redirected_to expertises_url
  end
end
