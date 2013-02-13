class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.column :name, :string, :limit => 25
      t.timestamps
    end
  end
end
