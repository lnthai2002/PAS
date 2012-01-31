class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.column :exp_date , :date
      t.column :exp_type_id, :integer
      t.column :amount, :decimal, :precision=>12, :scale=>2
      t.column :note, :string, :limit=>300
      t.column :payment_type_id, :integer
      t.timestamps
    end
  end
end
