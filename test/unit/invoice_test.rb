require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  setup do
    @invoice = Factory.create(:invoice)
  end
  
  should belong_to(:customer)
  should belong_to(:invoice_status)
  
  should validate_presence_of(:date)
  should validate_presence_of(:vat_rate)
end
