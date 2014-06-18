class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :code 
      
      t.text :description 
      t.integer :project_id 
      
      t.boolean :is_deleted, :default => false 

      t.timestamps
    end
  end
end
