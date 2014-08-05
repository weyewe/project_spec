class Part < ActiveRecord::Base
  belongs_to :group
  has_many :phases
  
  validates_presence_of :name  
  # validates_uniqueness_of :name  
  validates_presence_of :group_id
  
  
  validate :valid_group_id
  validate :uniq_name_in_given_group
  
  def valid_group_id
    return if group_id.nil? 
    assigned_group =  Group.find_by_id group_id
    
    if assigned_group.nil?
      self.errors.add(:group_id , "Harus ada dan valid")
      return self
    end
  end
 
  def uniq_name_in_given_group
    return if not name.present? 
    return if not group_id.present?
    
    current_name = self.name 
    
    ordered_detail_count  = Part.where(
      :group_id => group_id,
      :name => current_name,
      :is_deleted => false 
    ).count 
    
    ordered_detail = Part.where(
      :group_id => group_id,
      :name => current_name,
      :is_deleted => false
    ).first
    
    if self.persisted? and  ordered_detail.present? and ordered_detail.id != self.id   and ordered_detail_count == 1
      self.errors.add(:name, "Nama harus uniq dalam 1 group")
      return self 
    end
    
    # there is item with such item_id in the database
    if not self.persisted? and ordered_detail_count != 0 
      self.errors.add(:name, "Nama harus uniq dalam 1 group")
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
    if self.phases.count !=  0 
      self.errors.add(:generic_errors, "Sudah ada phases yang dibuat")
      return self 
    end
    
    self.is_deleted  = true 
    self.save  
    
  end 
  
  
  def self.active_objects
    self.where(:is_deleted => false )
  end
  
  def pre_conditions
    phase_id_list = self.phases.where(:is_deleted => false)
    Condition.where(
    :phase_id => phase_id_list,
      :is_deleted => false, 
      :case => SPEC_CASE[:pre]
    )
  end
  
  def pre_conditions_count
    pre_conditions.count
  end
  
  def post_conditions
    phase_id_list = self.phases.where(:is_deleted => false)
    Condition.where(
      :phase_id => phase_id_list,
      :is_deleted => false, 
      :case => SPEC_CASE[:post]
    )
  end
  
  def post_conditions_count
    post_conditions.count
  end
  
  def self.clone(old_object,  new_object)
    old_object.phases.where(:is_deleted => false).order("id ASC").each do |phase|
      
      new_phase = Phase.create_object(
        :name        =>  phase.name, 
        :description => phase.description, 
        :part_id     => new_object.id 
      )
      
      
      Phase.clone( phase, new_phase )
      
    end
    
  end
  
  
  
end
