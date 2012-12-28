class InvoiceLabour < ActiveRecord::Base
  belongs_to :invoice

  validates_presence_of :invoice_id, :on => :save, :unless => :nested
  validates_presence_of :details
  validates_presence_of :price

  validates_numericality_of :price
end
