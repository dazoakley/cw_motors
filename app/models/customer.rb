class Customer < ActiveRecord::Base
  belongs_to :customer_title
  
  validates_presence_of :first_name
  validates_presence_of :last_name
  
  validates_uniqueness_of :company, :scope => [:first_name, :last_name]
end
