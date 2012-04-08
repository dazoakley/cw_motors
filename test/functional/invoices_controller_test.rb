require 'test_helper'

class InvoicesControllerTest < ActionController::TestCase
  setup do
    @invoice = Factory.create(:invoice)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:invoices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create invoice" do
    assert_difference('Invoice.count') do
      post :create, :invoice => @invoice.attributes
    end

    assert_redirected_to invoice_path(assigns(:invoice))
  end

  test "should clean up badly formatted params" do
    customer = Factory.create(:customer)
    post :create, :invoice => Factory.attributes_for(:invoice, :customer => customer, :make_model => ' vw camper van ')
    invoice = Invoice.last
    assert_equal 'vw camper van', invoice.make_model
  end

  test "should show invoice" do
    get :show, :id => @invoice.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @invoice.to_param
    assert_response :success
  end

  test "should update invoice" do
    put :update, :id => @invoice.to_param, :invoice => @invoice.attributes
    assert_redirected_to invoice_path(assigns(:invoice))
  end

  test "should destroy invoice" do
    assert_difference('Invoice.count', -1) do
      delete :destroy, :id => @invoice.to_param
    end

    assert_redirected_to invoices_path
  end

  test "should allow bulk update of payment status" do
    @invoice2 = Factory.create(:invoice, { :paid => false })

    assert @invoice.paid  == true
    assert @invoice2.paid == false

    request.env["HTTP_REFERER"] = invoices_path

    put :paid, :invoice_ids => { @invoice.to_param => false, @invoice2.to_param => true }

    assert_redirected_to invoices_path

    assert Invoice.find(@invoice.id).paid  == false
    assert Invoice.find(@invoice2.id).paid == true
  end
end
