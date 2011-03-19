class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.references :customer_title
      t.string :first_name
      t.string :last_name
      t.string :company
      t.string :address_line1
      t.string :address_line2
      t.string :town
      t.string :county
      t.string :post_code
      t.string :telephone
      t.string :fax
      t.string :email
      t.text :notes
      
      t.timestamps
    end
    
    add_index :customers, [:first_name, :last_name, :company]
    add_foreign_key(:customers, :customer_titles)
  end

  def self.down
    drop_table :customers
  end
end
