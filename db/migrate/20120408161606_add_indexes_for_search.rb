class AddIndexesForSearch < ActiveRecord::Migration
  def self.up
    add_index :customers, :first_name
    add_index :customers, :last_name
    add_index :customers, :company

    add_index :invoices, :make_model
    add_index :invoices, :registration
  end

  def self.down
    remove_index :invoices, :column => :make_model
    remove_index :invoices, :column => :registration

    remove_index :customers, :column => :company
    remove_index :customers, :column => :last_name
    remove_index :customers, :column => :first_name
  end
end
