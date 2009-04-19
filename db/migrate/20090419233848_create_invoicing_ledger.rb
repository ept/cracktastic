class CreateInvoicingLedger < ActiveRecord::Migration
  def self.up
    create_table :ledger_items do |t|
      t.string :type
      t.integer :sender_id
      t.integer :recipient_id
      t.datetime :issue_date
      t.string :currency, :limit => 3, :null => false, :default => 'GBP'
      t.decimal :total_amount, :precision => 20, :scale => 4
      t.decimal :tax_amount, :precision => 20, :scale => 4
      t.string :status, :limit => 20
      t.string :description
      t.datetime :period_start
      t.datetime :period_end
      t.string :uuid, :limit => 40
      t.datetime :due_date
      t.timestamps
    end
    
    create_table :line_items do |t|
      t.string :type
      t.references :ledger_item
      t.decimal :net_amount, :precision => 20, :scale => 4
      t.decimal :tax_amount, :precision => 20, :scale => 4
      t.string :description
      t.string :uuid, :limit => 40
      t.datetime :tax_point
      t.decimal :quantity, :precision => 20, :scale => 4
      t.integer :creator_id
      t.timestamps
    end
  end 

  def self.down
    drop_table :line_items
    drop_table :ledger_items
  end
end
