class CreateInvoices < ActiveRecord::Migration
  def self.up
    create_table :invoices do |t|
      t.references :invoice_status
      t.references :customer
      t.date :date, :null => false
      t.string :make_model
      t.string :registration
      t.integer :mileage
      t.decimal :mot, :default => 0.00, :precision => 8, :scale => 2
      t.decimal :vat_rate, :default => 20.00, :null => false, :precision => 5, :scale => 2
      t.decimal :vat, :null => false, :precision => 8, :scale => 2
      t.decimal :subtotal, :null => false, :precision => 8, :scale => 2
      t.decimal :total, :null => false, :precision => 8, :scale => 2

      t.timestamps
    end
    
    add_foreign_key(:invoices, :invoice_statuses)
    add_foreign_key(:invoices, :customers)
  end

  def self.down
    remove_foreign_key(:invoices, :customers)
    remove_foreign_key(:invoices, :invoice_statuses)
    drop_table :invoices
  end
end
