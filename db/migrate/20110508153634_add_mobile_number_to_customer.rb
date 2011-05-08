class AddMobileNumberToCustomer < ActiveRecord::Migration
  def self.up
    add_column :customers, :mobile, :string
  end

  def self.down
    remove_column :customers, :mobile
  end
end