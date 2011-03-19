class CreateCustomerTitles < ActiveRecord::Migration
  def self.up
    create_table :customer_titles do |t|
      t.string :title, :null => false, :uniqe => true
      t.timestamps
    end
  end

  def self.down
    drop_table :customer_titles
  end
end
