class AddIndexToRxPayments < ActiveRecord::Migration
  def change
    add_index :rx_payments, [ :rx_number, :fill_number ]
  end
end
