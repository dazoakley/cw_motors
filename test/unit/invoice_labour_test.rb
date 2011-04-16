require 'test_helper'

class InvoiceLabourTest < ActiveSupport::TestCase
  setup do
    @invoice_labour = Factory.create(:invoice_labour)
  end
  
  should belong_to(:invoice)
  
  should validate_presence_of(:details)
  should validate_presence_of(:price)
  
  should validate_numericality_of(:price)
end
