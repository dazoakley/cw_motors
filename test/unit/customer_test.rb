require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  setup do
    @customer = Factory.create(:customer)
  end
  
  should belong_to(:customer_title)
  
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  
  should validate_uniqueness_of(:company).scoped_to(:first_name,:last_name)
end
