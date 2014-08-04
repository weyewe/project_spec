class Group < ActiveRecord::Base
  belongs_to :project
  has_many :parts 
  
  validates_presence_of :name  
  # validates_uniqueness_of :name  
  
  validates_presence_of :code  
  
  validates_presence_of :project_id
  
  
  validate :valid_project_id
  validate :unique_code_in_project 
  validate :uniq_name_in_given_project
  
  def valid_project_id
    return if project_id.nil? 
    assigned_project =  Project.find_by_id project_id
    
    if assigned_project.nil?
      self.errors.add(:project_id , "Harus ada dan valid")
      return self
    end
  end
  
  
  def unique_code_in_project
    return if not code.present? 
    return if not project_id.present? 
    
    
    current_code = self.code 
    current_project_id = self.project_id 
    group_count = self.class.where(
      :code =>  current_code ,
      :project_id => current_project_id
    ).count 
    
    if self.persisted? and group_count > 1 
      self.errors.add(:code , "Kode group harus unique")
      return self 
    end
    
    if not self.persisted? and group_count > 0 
      self.errors.add(:code , "Kode group harus unique")
      return self
    end
  end
  
  def uniq_name_in_given_project
    return if not name.present? 
    return if not project_id.present?
    
    current_name = self.name 
    
    ordered_detail_count  = Group.where(
      :project_id => project_id,
      :name => current_name
    ).count 
    
    ordered_detail = Group.where(
      :project_id => project_id,
      :name => current_name
    ).first
    
    if self.persisted? and  ordered_detail.present? and ordered_detail.id != self.id   and ordered_detail_count == 1
      self.errors.add(:name, "Nama harus uniq dalam 1 project")
      return self 
    end
    
    # there is item with such item_id in the database
    if not self.persisted? and ordered_detail_count != 0 
      self.errors.add(:name, "Nama harus uniq dalam 1 project")
      return self
    end
  end
  
 
  
  def self.create_object( params ) 
    new_object           = self.new
    new_object.name    =  ( params[:name].present? ? params[:name   ].to_s.upcase : nil )  
    new_object.description  = params[:description]
    new_object.code  = ( params[:code].present? ? params[:code   ].to_s.upcase : nil )  
    new_object.project_id      = params[:project_id    ]
    
    new_object.save
    
    return new_object
  end
  
  
   
  
  def update_object(params)
    self.name    =  ( params[:name].present? ? params[:name   ].to_s.upcase : nil )  
    self.description  = params[:description]
    self.project_id      = params[:project_id    ]
    self.code    =  ( params[:code].present? ? params[:code   ].to_s.upcase : nil )  
    self.save
    
    return self
  end
  
  def delete_object
    
    if self.parts.count != 0 
      self.errors.add(:generic_errors, "Sudah ada entity yang telah dibuat")
      return self
    end
    
    
    self.is_deleted  = true 
    self.save  
    
  end 
  
  
  def self.active_objects
    self.where(:is_deleted => false )
  end
  
  def self.clone( old_object, new_object)
    old_object.parts.where(:is_deleted => false ).order("id ASC").each do |part|
      new_part = Part.create_object(
        :name        =>  part.name,
        :description => part.description, 
        :group_id    => new_object.id 

      )
      
      Part.clone( part, new_part )
    
    
    end
    
    
  end
  
end
