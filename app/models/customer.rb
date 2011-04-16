class Customer < ActiveRecord::Base
  belongs_to :customer_title
  has_many :invoices
  
  validates_presence_of :first_name
  validates_presence_of :last_name
  
  validates_uniqueness_of :company, :scope => [:first_name, :last_name]
  
  def short_code
    str =  ""
    str << "#{self.company}" unless self.company.blank?
    
    if !self.company.blank? and !( self.first_name.blank? or self.last_name.blank? )
      str << " - "
    end
    
    str << "#{self.first_name} " unless self.first_name.blank?
    str << "#{self.last_name}" unless self.last_name.blank?
    str
  end
end
