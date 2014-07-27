class Condition < ActiveRecord::Base
  belongs_to :phase
  belongs_to :project
  
  validates_presence_of :phase_id
  validates_presence_of :case 
  
  validate :valid_phase_id
  validate :valid_case
  validate :valid_project_phase_combination
  
  def valid_case
    possible_cases = [
        SPEC_CASE[:pre],
        SPEC_CASE[:post]
      ]
      
    if not possible_cases.include?(self.case) 
      self.errors.add(:case, "Harus ada dan valid")
      return self 
    end
  end
  
  
  def valid_phase_id
    return if phase_id.nil? 
    assigned_phase =  Phase.find_by_id phase_id
    
    if assigned_phase.nil?
      self.errors.add(:phase_id , "Harus ada dan valid")
      return self
    end
  end
  
  def valid_project_id
    return if project_id.nil? 
    assigned_project =  Project.find_by_id project_id
    
    if assigned_project.nil?
      self.errors.add(:project_id , "Harus ada dan valid")
      return self
    end
  end
  
  def valid_project_phase_combination
    return if phase_id.nil? or project_id.nil? 
    
    selected_project = phase.part.group.project 
    
    if selected_project.id != project_id 
      self.errors.add(:phase_id, "Harus berasal dari project yang dipilih")
      return self 
    end
    
    
  end
  
  
  def self.create_object( params ) 
    new_object           = self.new
    new_object.description  = params[:description]
    new_object.case      = params[:case    ]
    new_object.phase_id      = params[:phase_id    ]
    
    
    if new_object.save
      new_object.project_id      = new_object.phase.part.group.project_id 
      
      new_object.code = new_object.phase.code + "." + 
                        new_object.case.to_s + "." +  
                        new_object.phase.conditions.where(:case => new_object.case).count.to_s  
      new_object.save 
    end
    
    return new_object
  end
  
  
   
  
  def update_object(params)
    self.description  = params[:description]
    
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
