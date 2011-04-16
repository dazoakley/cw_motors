class Invoice < ActiveRecord::Base
  belongs_to :invoice_status
  belongs_to :customer
  
  has_many :invoice_labours, :dependent => :destroy
  
  accepts_nested_attributes_for :invoice_labours, :allow_destroy => true, :reject_if => Proc.new { |il| il[:price].blank? }
  
  validates_presence_of :customer_id
  validates_presence_of :date
  validates_presence_of :vat_rate
  
  validates_numericality_of :mileage, :only_integer => true, :allow_blank => true
  validates_numericality_of :mot
  validates_numericality_of :vat_rate
  validates_numericality_of :vat
  validates_numericality_of :subtotal
  validates_numericality_of :total
  
  before_validation :set_date_to_today, :if => Proc.new { |a| a.date.blank? }
  before_validation :calculate_subtotal
  before_validation :calculate_vat
  before_validation :calculate_total
  
  private
    
    def set_date_to_today
      self.date = Date.today()
    end
    
    def calculate_subtotal
      subtotal = 0.00
      self.invoice_labours.each do |il|
        subtotal += il.price
      end
      self.subtotal = subtotal
    end
    
    def calculate_vat
      self.vat = ( self.subtotal / 100 ) * self.vat_rate
    end
    
    def calculate_total
      self.total = self.subtotal + self.vat + self.mot
    end
end
