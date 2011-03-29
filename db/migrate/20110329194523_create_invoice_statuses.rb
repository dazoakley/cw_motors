class CreateInvoiceStatuses < ActiveRecord::Migration
  def self.up
    create_table :invoice_statuses do |t|
      t.string :status, :null => false

      t.timestamps
    end
    
    add_index :invoice_statuses, [:status], :unique => true
  end

  def self.down
    remove_index :invoice_statuses, :column => [:status]
    drop_table :invoice_statuses
  end
end