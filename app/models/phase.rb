class Phase < ActiveRecord::Base
  belongs_to :part
  has_many :conditions
  
  validates_presence_of :name  
  validates_uniqueness_of :name  
  validates_presence_of :part_id
  
  
  validate :valid_part_id
  
  def valid_part_id
    return if part_id.nil? 
    assigned_part =  Part.find_by_id part_id
    
    if assigned_part.nil?
      self.errors.add(:part_id , "Harus ada dan valid")
      return self
    end
  end
 
  
  def self.create_object( params ) 
    new_object           = self.new
    new_object.name    =  ( params[:name].present? ? params[:name   ].to_s.upcase : nil )  
    new_object.description  = params[:description]
     
    new_object.part_id      = params[:part_id    ]
    
    if new_object.save
      new_object.code = new_object.part.code + "." + new_object.part.phases.count.to_s  
      new_object.save 
    end
    
    return new_object
  end
  
  
   
  
  def update_object(params)
    self.name    =  ( params[:name].present? ? params[:name   ].to_s.upcase : nil )  
    self.description  = params[:description]
    self.part_id      = params[:part_id    ]
    self.save
    
    return self
  end
  
  def delete_object
    self.is_deleted  = true 
    self.save  
  end 
  
  
  def self.active_objects
    self.where(:is_deleted => false )
  end
  
end
