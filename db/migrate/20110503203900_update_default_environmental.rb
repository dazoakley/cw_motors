class UpdateDefaultEnvironmental < ActiveRecord::Migration
  def self.up
    change_column_default :invoices, :environmental, 6.00
  end

  def self.down
    change_column_default :invoices, :environmental, 0.00
  end
end