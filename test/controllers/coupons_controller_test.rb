require 'test_helper'

class CouponsControllerTest < ActionController::TestCase
  test "should get generate_coupon_code" do
    get :generate_coupon_code
    assert_response :success
  end

  test "should get check_coupon_code" do
    get :check_coupon_code
    assert_response :success
  end

end
