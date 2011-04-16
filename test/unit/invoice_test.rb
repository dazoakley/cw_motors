require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  setup do
    @invoice = Factory.create(:invoice)
  end
  
  should belong_to(:customer)
  should belong_to(:invoice_status)
  
  should have_many(:invoice_labours)
  
  should validate_presence_of(:date)
  should validate_presence_of(:vat_rate)
  
  should validate_numericality_of(:mot)
  should validate_numericality_of(:vat_rate)
  should validate_numericality_of(:vat)
  should validate_numericality_of(:subtotal)
  should validate_numericality_of(:total)
end
