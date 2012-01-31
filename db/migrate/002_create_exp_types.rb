class CreateExpTypes < ActiveRecord::Migration
  def change
    create_table :exp_types do |t|
      t.column :description, :string, :limit=>64
      t.timestamps
    end
  end
end