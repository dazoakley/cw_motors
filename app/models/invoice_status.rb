class InvoiceStatus < ActiveRecord::Base
  has_many :invoices
  
  validates_presence_of :status
  validates_uniqueness_of :status
end
