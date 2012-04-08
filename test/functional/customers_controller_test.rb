require 'test_helper'

class CustomersControllerTest < ActionController::TestCase
  setup do
    @customer = Factory.create(:customer)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customers)
  end

  test "should allow searching on the index page" do
    Factory.create(:customer, :first_name => 'Joe', :last_name => 'Blogs')
    get :index, :query => 'blo'
    assert_response :success
    assert_not_nil assigns(:customers)
    assert_select 'td', 'Blogs'
    assert !@response.body.include?('Doe')
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customer" do
    assert_difference('Customer.count') do
      post :create, :customer => Factory.attributes_for(:customer, :company => "John's New Corp" )
    end

    assert_redirected_to customer_path(assigns(:customer))
  end

  test "should clean up badly formatted params" do
    post :create, :customer => Factory.attributes_for(:customer, :first_name => ' Bob', :last_name => 'Flemming  ')

    customer = Customer.last
    assert_equal 'Bob', customer.first_name
    assert_equal 'Flemming', customer.last_name
  end

  test "should show customer" do
    get :show, :id => @customer.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @customer.to_param
    assert_response :success
  end

  test "should update customer" do
    put :update, :id => @customer.to_param, :customer => @customer.attributes
    assert_redirected_to customer_path(assigns(:customer))
  end

  test "should destroy customer" do
    assert_difference('Customer.count', -1) do
      delete :destroy, :id => @customer.to_param
    end

    assert_redirected_to customers_path
  end
end
