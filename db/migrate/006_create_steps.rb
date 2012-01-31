class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.column :recipe_id, :integer
      t.column :sequence_number, :integer
      t.column :description, :string
      t.timestamps
    end
  end
end
