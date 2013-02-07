class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.column :email, :string
      t.column :encrypted_password, :string
      t.column :encryption_salt, :string
      t.timestamps
    end
  end
end
