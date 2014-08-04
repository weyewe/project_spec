class Project < ActiveRecord::Base
  belongs_to :customer
  has_many :groups 
  has_many :conditions
  
  validates_presence_of :name  
  validates_uniqueness_of :name  
  
  validates_presence_of :customer_id
  
  
  validate :valid_customer_id
  
  def valid_customer_id
    return if customer_id.nil? 
    assigned_customer =  Customer.find_by_id customer_id
    
    if assigned_customer.nil?
      self.errors.add(:customer_id , "Harus ada dan valid")
      return self
    end
  end
 
  
  def self.create_object( params ) 
    new_object           = self.new
    new_object.name    =  ( params[:name].present? ? params[:name   ].to_s.upcase : nil )  
    new_object.description  = params[:description]
    new_object.customer_id      = params[:customer_id    ]
    
    new_object.save
    
    return new_object
  end
  
  
   
  
  def update_object(params)
    self.name    =  ( params[:name].present? ? params[:name   ].to_s.upcase : nil )  
    self.description  = params[:description]
    self.customer_id      = params[:customer_id    ]
    
    self.save
    
    return self
  end
  
  def delete_object
    if self.groups.count != 0 
      self.errors.add(:generic_errors, "Sudah ada group yang telah dibuat")
      return self
    end
    
    self.is_deleted  = true 
    self.save  
    
  end 
  
  
  def self.active_objects
    self.where(:is_deleted => false )
  end
  
  def parts
    group_id_list = self.groups.where(:is_deleted => false).map{|x| x.id }
    Part.where(:is_deleted => false, :group_id => group_id_list )
  end
  
  def parts_count
    parts.count
  end
  
  def phases
    part_id_list = self.parts.map{ |x| x.id }
    Phase.where(:is_deleted => false, :part_id => part_id_list)
  end
  
  def phases_count
    phases.count 
  end
  
  def pre_conditions_count
    self.conditions.where(:is_deleted => false , :case =>SPEC_CASE[:pre]).count
  end
  
  def post_conditions_count
    self.conditions.where(:is_deleted => false , :case =>SPEC_CASE[:post]).count
  end
  
  def self.clone( old_object, new_object)
    old_object.groups.where(:is_deleted => false).order("id ASC").each do |group|
      new_group = Group.create_object(
      :name        => group.name, 
      :description => group.description,
      :code        => group.code, 
      :project_id  => new_object.id 
      )
      
      Group.clone(group, new_group )
       
      
    end
  end
  
end
