class CustomerTitle < ActiveRecord::Base
  has_many :customers
  
  validates_presence_of :title
  validates_uniqueness_of :title
end
