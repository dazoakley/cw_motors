class CreateInvoiceLabours < ActiveRecord::Migration
  def self.up
    create_table :invoice_labours do |t|
      t.references :invoice
      t.text :details, :null => false
      t.decimal :price, :null => false, :precision => 8, :scale => 2

      t.timestamps
    end
    
    add_foreign_key(:invoice_labours, :invoices)
  end

  def self.down
    remove_foreign_key(:invoice_labours, :invoices)
    drop_table :invoice_labours
  end
end
