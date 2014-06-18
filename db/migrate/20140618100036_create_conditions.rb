class CreateConditions < ActiveRecord::Migration
  def change
    create_table :conditions do |t|
      t.integer :phase_id
      t.integer :project_id 
      
      t.string :code 
      t.text :description 
      
      t.integer :case 
      t.boolean :is_deleted, :default => false
      
      t.timestamps
    end
  end
end
