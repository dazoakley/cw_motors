class Invoice < ActiveRecord::Base
  belongs_to :customer
  
  has_many :invoice_labours, :dependent => :destroy
  has_many :invoice_parts, :dependent => :destroy
  
  accepts_nested_attributes_for :invoice_labours, :allow_destroy => true, :reject_if => Proc.new { |il| il[:price].blank? }
  accepts_nested_attributes_for :invoice_parts,   :allow_destroy => true, :reject_if => Proc.new { |ip| ip[:price].blank? }
  
  validates_presence_of :customer_id
  validates_presence_of :date
  validates_presence_of :vat_rate
  
  validates_numericality_of :mileage, :only_integer => true, :allow_blank => true
  validates_numericality_of :mot
  validates_numericality_of :vat_rate
  validates_numericality_of :vat
  validates_numericality_of :subtotal
  validates_numericality_of :total
  
  before_validation :set_date_to_today, :if => Proc.new { |i| i.date.blank? }
  before_validation :calculate_subtotal
  before_validation :calculate_vat
  before_validation :calculate_total
  
  before_save :stamp_date_paid, :if => Proc.new { |i| i.paid == true }
  before_save :remove_date_paid, :if => Proc.new { |i| i.paid == false }
  
  def total_labour
    total_labour = 0.00
    self.invoice_labours.each { |il| total_labour += il.price }
    return total_labour
  end
  
  def total_parts
    total_parts = 0.00
    self.invoice_parts.each { |ip| total_parts += ip.price }
    return total_parts
  end
  
  private
    
    def stamp_date_paid
      self.date_paid = Date.today() if date_paid.blank?
    end
    
    def remove_date_paid
      self.date_paid = nil unless date_paid.blank?
    end
    
    def set_date_to_today
      self.date = Date.today()
    end
    
    def calculate_subtotal
      subtotal = 0.00
      self.invoice_labours.each { |il| subtotal += il.price }
      self.invoice_parts.each   { |ip| subtotal += ip.price }
      self.subtotal = subtotal
    end
    
    def calculate_vat
      self.vat = ( self.subtotal / 100 ) * self.vat_rate
    end
    
    def calculate_total
      self.total = self.subtotal + self.vat + self.mot
    end
end
