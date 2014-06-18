class Part < ActiveRecord::Base
  belongs_to :group
  has_many :phases
  
  validates_presence_of :name  
  validates_uniqueness_of :name  
  validates_presence_of :group_id
  
  
  validate :valid_group_id
  
  def valid_group_id
    return if group_id.nil? 
    assigned_group =  Group.find_by_id group_id
    
    if assigned_group.nil?
      self.errors.add(:group_id , "Harus ada dan valid")
      return self
    end
  end
 
  
  def self.create_object( params ) 
    new_object           = self.new
    new_object.name    =  ( params[:name].present? ? params[:name   ].to_s.upcase : nil )  
    new_object.description  = params[:description]
     
    new_object.group_id      = params[:group_id    ]
    
    if new_object.save
      new_object.code = new_object.group.code +  "." + new_object.group.parts.count.to_s  
      new_object.save 
    end
    
    return new_object
  end
  
  
   
  
  def update_object(params)
    self.name    =  ( params[:name].present? ? params[:name   ].to_s.upcase : nil )  
    self.description  = params[:description]
    self.group_id      = params[:group_id    ]
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