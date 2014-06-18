class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :customer_id
      t.string :name 
      t.text :description 
      
      t.boolean :is_deleted, :default => false

      t.timestamps
    end
  end
end
