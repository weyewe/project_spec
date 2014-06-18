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
    self.is_deleted  = true 
    self.save  
    
  end 
  
  
  def self.active_objects
    self.where(:is_deleted => false )
  end
  
end
