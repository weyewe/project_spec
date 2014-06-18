class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.integer :group_id
      t.string :name 
      t.string :code 
      t.text :description 
      
      t.boolean :is_deleted, :default => false 

      t.timestamps
    end
  end
end
