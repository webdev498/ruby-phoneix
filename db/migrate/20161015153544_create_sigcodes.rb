class CreateSigcodes < ActiveRecord::Migration
  def change
    create_table :sigcodes do |t|
      t.integer :company_id
      t.integer :pharmacy_id
      t.string :sig_code, limit: 8
      t.boolean :active
      t.integer :language
      t.text :expanded_text
      t.integer :frequency

      t.timestamps null: false
    end
  end
end
