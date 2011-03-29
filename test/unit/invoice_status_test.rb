require 'test_helper'

class InvoiceStatusTest < ActiveSupport::TestCase
  should have_many(:invoices)
  
  should validate_presence_of(:status)
  should validate_uniqueness_of(:status)
end
