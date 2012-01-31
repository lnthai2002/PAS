class CreatePaymentTypes < ActiveRecord::Migration
  def change
    create_table :payment_types do |t|
      t.column :description, :string, :limit=>64
      t.timestamps
    end
  end
end
