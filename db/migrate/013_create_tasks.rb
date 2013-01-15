class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.column :worker, :string, :limit=>50
      t.column :target, :string, :limit=>255
      t.column :status, :string, :limit=>10
      t.timestamps
    end
  end
end
