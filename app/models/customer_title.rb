class CustomerTitle < ActiveRecord::Base
  acts_as_reportable

  has_many :customers

  validates_presence_of :title
  validates_uniqueness_of :title
end
