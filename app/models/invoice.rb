class Invoice < ActiveRecord::Base
  belongs_to :invoice_status
  belongs_to :customer
  
  validates_presence_of :date
  validates_presence_of :vat_rate
end
