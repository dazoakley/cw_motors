require 'test_helper'

class InvoicePartTest < ActiveSupport::TestCase
  setup do
    @invoice_part = Factory.create(:invoice_part)
  end
  
  should belong_to(:invoice)
  
  should validate_presence_of(:details)
  should validate_presence_of(:price)
  
  should validate_numericality_of(:price)
end
