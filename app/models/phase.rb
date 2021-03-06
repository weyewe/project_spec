class Phase < ActiveRecord::Base
  belongs_to :part
  has_many :conditions
  
  validates_presence_of :name  
  # validates_uniqueness_of :name  
  validates_presence_of :part_id
  
  
  validate :valid_part_id
  validate :uniq_name_in_given_part
  
  def valid_part_id
    return if part_id.nil? 
    assigned_part =  Part.find_by_id part_id
    
    if assigned_part.nil?
      self.errors.add(:part_id , "Harus ada dan valid")
      return self
    end
  end
  
  def uniq_name_in_given_part
    return if not name.present? 
    return if not part_id.present?
    
    current_name = self.name 
    
    ordered_detail_count  = Phase.where(
      :part_id => part_id,
      :name => current_name,
      :is_deleted => false
    ).count 
    
    ordered_detail = Phase.where(
      :part_id => part_id,
      :name => current_name,
      :is_deleted => false
    ).first
    
    if self.persisted? and  ordered_detail.present? and ordered_detail.id != self.id   and ordered_detail_count == 1
      self.errors.add(:name, "Nama harus uniq dalam 1 part")
      return self 
    end
    
    # there is item with such item_id in the database
    if not self.persisted? and ordered_detail_count != 0 
      self.errors.add(:name, "Nama harus uniq dalam 1 part")
      return self
    end
  end 
 
 
  def pre_conditions
    self.conditions.where(:is_deleted => false, :case => SPEC_CASE[:pre])
  end
  
  def post_conditions
    self.conditions.where(:is_deleted => false, :case => SPEC_CASE[:post])
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
    
    if self.conditions.count != 0 
      self.errors.add(:generic_errors, "Sudah ada kondisi yang telah dibuat")
      return self
    end
    
    self.is_deleted  = true 
    self.save  
  end 
  
  
  def self.active_objects
    self.where(:is_deleted => false )
  end
  
  def self.clone( old_object , new_object ) 
    old_object.pre_conditions.where(:is_deleted => false ).order("id ASC").each do |pre_condition|
      Condition.create_object(
        :description =>  pre_condition.description , 
        :case        =>  pre_condition.case, 
        :phase_id    => new_object.id 
      )
    end

    old_object.post_conditions.where(:is_deleted => false ).order("id ASC").each do |post_condition|
      Condition.create_object(
        :description =>  post_condition.description , 
        :case        =>  post_condition.case, 
        :phase_id    => new_object.id 
      )
    end
  end
  
  def pre_conditions
    Condition.where(
    :phase_id => self.id ,
      :is_deleted => false, 
      :case => SPEC_CASE[:pre]
    )
  end
  
  def pre_conditions_count
    pre_conditions.count 
  end
  
  def post_conditions
    Condition.where(
    :phase_id => self.id ,
      :is_deleted => false, 
      :case => SPEC_CASE[:post]
    )
  end
  
  def post_conditions_count
    post_conditions.count 
  end
  
end
