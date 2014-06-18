class CreatePhases < ActiveRecord::Migration
  def change
    create_table :phases do |t|
      t.integer :group_id
      t.string :name 
      t.string :code 
      t.text :description 
      t.integer :part_id 
      
      t.boolean :is_deleted, :default => false
      

      t.timestamps
    end
  end
end
