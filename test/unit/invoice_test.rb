require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  setup do
    @invoice  = Factory.create(:invoice)
  end
  
  should belong_to(:customer)
  
  should have_many(:invoice_labours)
  should have_many(:invoice_parts)
  
  should validate_numericality_of(:mot)
  should validate_numericality_of(:environmental)
  should validate_numericality_of(:vat_rate)
end
