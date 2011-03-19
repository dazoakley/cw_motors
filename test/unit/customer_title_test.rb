require 'test_helper'

class CustomerTitleTest < ActiveSupport::TestCase
  should have_many(:customers)
  
  should validate_presence_of(:title)
  should validate_uniqueness_of(:title)
end
