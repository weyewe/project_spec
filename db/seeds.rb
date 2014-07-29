role = {
  :system => {
    :administrator => true
  }
}

admin_role = Role.create!(
  :name        => ROLE_NAME[:admin],
  :title       => 'Administrator',
  :description => 'Role for administrator',
  :the_role    => role.to_json
)

role = {
  :passwords => {
    :update => true 
  },
  :works => {
    :index => true, 
    :create => true,
    :update => true,
    :destroy => true,
    :work_reports => true ,
    :project_reports => true ,
    :category_reports => true 
  },
  :projects => {
    :search => true 
  },
  :categories => {
    :search => true 
  }
}

data_entry_role = Role.create!(
  :name        => ROLE_NAME[:data_entry],
  :title       => 'Data Entry',
  :description => 'Role for data_entry',
  :the_role    => role.to_json
)



# if Rails.env.development?

  admin = User.create_main_user(  :name => "Admin", :email => "admin@gmail.com" ,:password => "willy1234", :password_confirmation => "willy1234") 
  admin.set_as_main_user


  admin = User.create_main_user(  :name => "Admin2", :email => "admin2@gmail.com" ,:password => "willy1234", :password_confirmation => "willy1234") 
  admin.set_as_main_user
  
  admin = User.create_main_user(  :name => "Admin4", :email => "admin4@gmail.com" ,:password => "willy1234", :password_confirmation => "willy1234") 
  admin.set_as_main_user


  
  customer_1 = Customer.create_object(
    :name        => "mcnell", 
    :address     => " kalibesar no 50 ", 
    :pic         => " WILLY ", 
    :contact     => "082125583534", 
    :email       => "walawee@gmail.com", 
  )
  
  customer_2 = Customer.create_object(
    :name        => "toll", 
    :address     => " kalibesar no 50 ", 
    :pic         => " WILLY ", 
    :contact     => "082125583534", 
    :email       => "toll@gmail.com", 
  )
  
  customer_3 = Customer.create_object(
    :name        => "penanshin", 
    :address     => " kalibesar no 50 ", 
    :pic         => " WILLY ", 
    :contact     => "082125583534", 
    :email       => "toll@gmail.com", 
  )
  
  customer_array = [customer_1, customer_2, customer_3 ]
  
  type_pc = Type.create_object(
    :name => "PC",
    :description => "Seperangkat komputer: mouse, CPU, Monitor, Speaker (optional)"
  )
  
  type_laptop = Type.create_object(
    :name => "Laptop",
    :description => "Awesome"
  )
  
  type_array = [type_pc, type_laptop]
  
  
  (1..3).each do |x|
    customer_array.each do |customer_object|
      type_array.each do |type_object|
        
        Item.create_object(
          :customer_id              => customer_object.id,
          :type_id                  => type_object.id,
          :description              => "#{customer_object.name} #{type_object.name} #{x} ",
          :manufactured_at          => DateTime.new(2011, 10,10), 
          :warranty_expiry_date     => DateTime.new(2013, 10,10)
        )
      end
    end
  end
  
  puts "Total item: #{Item.all.count}"
  
  
  (1..3).each do |x|
    customer_array.each do |customer_object|
      ContractMaintenance.create_object(
        :customer_id  =>  customer_object.id, 
        :description  =>  "description #{customer_object.id}, count #{x}", 
        :name         =>  "name #{x*customer_object.id}", 
        :started_at   =>  DateTime.new(2011, 10,10), 
        :finished_at  =>  DateTime.new(2014, 10,10)
      )
    end
  end
  
  puts "Total Contract Maintenance #{ContractMaintenance.all.count}"
  
  
  customer_array.each do |customer|
    customer.items.each do |item|
      first_contract_maintenance = customer.contract_maintenances.first 
      ContractItem.create_object(
        :item_id => item.id ,
        :customer_id => customer.id,
        :contract_maintenance_id => first_contract_maintenance.id 
      )
    end
  end
  
  puts "Total ContractItem: #{ContractItem.all.count}"
  
  
  puts "\n\n============> Project Spec here \n"
  
  project = Project.create_object(
    :name =>  "Zengra",
    :description => "Awesome first project",
    :customer_id => Customer.first.id
  )
  
  puts "Total project: #{Project.count}"
  
  ["O","M","K"].each do |code|
    Group.create_object(
      :name => "Group #{code}",
      :code => code ,
      :description => "Awesome Group #{code}",
      :project_id => project.id 
    )
  end
  
  puts "Total group: #{Group.count}"
  
  Group.all.each do |group|
    a = Part.create_object(
      :name => "part#{group.code}",
      :description =>  "Awesome part #{group.code}",
      :group_id => group.id
    )
    
    if a.errors.size != 0 
      a.errors.messages.each {|x| puts x}
    end
  end
  
  
  puts "Total Part: #{Part.count}"
  
  Part.all.each do |part|
    Phase.create_object(
      :name => "#{part.name}Entity",
      :description => "Entity for shite",
      :part_id => part.id 
    )
  end
  
  puts "Total Phase: #{Phase.count}"
  
  Phase.all.each do |phase|
    Condition.create_object(
      :case => SPEC_CASE[:pre],
      :description => "Description  pre condition#{phase.id} of phase #{phase.name}",
      :phase_id =>  phase.id ,
      :project_id => project.id 
    )
    
    Condition.create_object(
      :case => SPEC_CASE[:post],
      :description => "Description  POST condition#{phase.id} of phase #{phase.name}",
      :phase_id =>  phase.id ,
      :project_id => project.id 
    )
  end
  
  puts "Total spec from project #{project.name}: #{project.conditions.count} "
  puts "Total pre-condition: #{project.conditions.where(:case => SPEC_CASE[:pre]).count}"
  puts "Total post-condition: #{project.conditions.where(:case => SPEC_CASE[:post]).count}"
  
  
  customer = Customer.create_object(
    :name        => "ssd", 
    :address     => " kalibesar no 50 ", 
    :pic         => " WILLY ", 
    :contact     => "082125583534", 
    :email       => "walawee@gmail.com", 
  )
  
  
  project = Project.create_object(
    :name =>  "Hardware Maintenance",
    :description => "Awesome first project",
    :customer_id => customer.id
  )
  
  operation_group = Group.create_object(
    :name => "Operasional",
    :code => "O" ,
    :description => "Recording data operasional SSD IT support",
    :project_id => project.id 
  )
  
=begin
  User Entity used 
=end
  
  user_entity = Part.create_object(
    :name => "User",
    :description =>  "The IT Staff that are doing operation",
    :group_id => operation_group.id
  )
  
    create_phase = Phase.create_object(
      :name => "Create",
      :description => "Create object",
      :part_id => user_entity.id 
    )
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "Name must be present and unique",
        :phase_id =>  create_phase.id ,
        :project_id => project.id 
      )

      Condition.create_object(
        :case => SPEC_CASE[:post],
        :description => "Auto create CreatedAt = DateTime.now",
        :phase_id =>  create_phase.id ,
        :project_id => project.id 
      )
    
    update_phase = Phase.create_object(
      :name => "Update",
      :description => "Update object",
      :part_id => user_entity.id 
    )
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "Name must be present and unique",
        :phase_id =>  update_phase.id ,
        :project_id => project.id 
      )

      Condition.create_object(
        :case => SPEC_CASE[:post],
        :description => "AutoCreate UpdatedAt= DateTime.now",
        :phase_id =>  update_phase.id ,
        :project_id => project.id 
      )
    
    destroy_phase = Phase.create_object(
      :name => "Destroy",
      :description => "Destroy object",
      :part_id => user_entity.id 
    )
    
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "Can't be destroyed if there is Maintenance associated with this item",
        :phase_id =>  destroy_phase.id ,
        :project_id => project.id 
      )

      Condition.create_object(
        :case => SPEC_CASE[:post],
        :description => "DeletedAt = DateTime.now",
        :phase_id =>  destroy_phase.id ,
        :project_id => project.id 
      )
      
      Condition.create_object(
        :case => SPEC_CASE[:post],
        :description => "soft destroy: mark column IsDeleted to be true",
        :phase_id =>  destroy_phase.id ,
        :project_id => project.id 
      )
    
=begin
  Item Type Entity used 
=end  
  type_entity = Part.create_object(
    :name => "ItemType",
    :description =>  "Item Type being serviced/supported",
    :group_id => operation_group.id
  )
    create_phase = Phase.create_object(
      :name => "Create",
      :description => "Create object",
      :part_id => type_entity.id 
    )
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "Name must be present and unique",
        :phase_id =>  create_phase.id ,
        :project_id => project.id 
      )

      Condition.create_object(
        :case => SPEC_CASE[:post],
        :description => "Auto create CreatedAt = DateTime.now",
        :phase_id =>  create_phase.id ,
        :project_id => project.id 
      )
    
    update_phase = Phase.create_object(
      :name => "Update",
      :description => "Update object",
      :part_id => type_entity.id 
    )
    
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "Name must be present and unique",
        :phase_id =>  update_phase.id ,
        :project_id => project.id 
      )

      Condition.create_object(
        :case => SPEC_CASE[:post],
        :description => "Auto create CreatedAt = DateTime.now",
        :phase_id =>  update_phase.id ,
        :project_id => project.id 
      )
      
    destroy_phase = Phase.create_object(
      :name => "Destroy",
      :description => "Destroy object",
      :part_id => type_entity.id 
    )
    
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "Can't be destroyed if there is Maintenance associated with this Type",
        :phase_id =>  destroy_phase.id ,
        :project_id => project.id 
      )
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "Can't be destroyed if there is Item associated with this Type",
        :phase_id =>  destroy_phase.id ,
        :project_id => project.id 
      )

      Condition.create_object(
        :case => SPEC_CASE[:post],
        :description => "DeletedAt = DateTime.now",
        :phase_id =>  destroy_phase.id ,
        :project_id => project.id 
      )
      
      Condition.create_object(
        :case => SPEC_CASE[:post],
        :description => "soft destroy: mark column IsDeleted to be true",
        :phase_id =>  destroy_phase.id ,
        :project_id => project.id 
      )
      
      

=begin
  Customer Entity used 
=end  
  customer_entity = Part.create_object(
    :name => "Customer",
    :description =>  "Companies under our management",
    :group_id => operation_group.id
  )
  
    create_phase = Phase.create_object(
      :name => "Create",
      :description => "Create object",
      :part_id => customer_entity.id 
    )
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "Name must be present and unique",
        :phase_id =>  create_phase.id ,
        :project_id => project.id 
      )

      Condition.create_object(
        :case => SPEC_CASE[:post],
        :description => "Auto create CreatedAt = DateTime.now",
        :phase_id =>  create_phase.id ,
        :project_id => project.id 
      )
  
    update_phase = Phase.create_object(
      :name => "Update",
      :description => "Update object",
      :part_id => customer_entity.id 
    )
  
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "Name must be present and unique",
        :phase_id =>  update_phase.id ,
        :project_id => project.id 
      )

      Condition.create_object(
        :case => SPEC_CASE[:post],
        :description => "Auto create CreatedAt = DateTime.now",
        :phase_id =>  update_phase.id ,
        :project_id => project.id 
      )
    
    destroy_phase = Phase.create_object(
      :name => "Destroy",
      :description => "Destroy object",
      :part_id => customer_entity.id 
    )
  
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "Can't be destroyed if there is Maintenance associated with this Customer",
        :phase_id =>  destroy_phase.id ,
        :project_id => project.id 
      )
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "Can't be destroyed if there is Item associated with this Customer",
        :phase_id =>  destroy_phase.id ,
        :project_id => project.id 
      )

      Condition.create_object(
        :case => SPEC_CASE[:post],
        :description => "DeletedAt = DateTime.now",
        :phase_id =>  destroy_phase.id ,
        :project_id => project.id 
      )
    
      Condition.create_object(
        :case => SPEC_CASE[:post],
        :description => "soft destroy: mark column IsDeleted to be true",
        :phase_id =>  destroy_phase.id ,
        :project_id => project.id 
      )
  


=begin
  Item Entity used 
=end  
  item_entity = Part.create_object(
    :name => "Item",
    :description =>  "All items registered for a given customer",
    :group_id => operation_group.id
  )
    create_phase = Phase.create_object(
      :name => "Create",
      :description => "Create object",
      :part_id => item_entity.id 
    )
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "CustomerId must be present and unique",
        :phase_id =>  create_phase.id ,
        :project_id => project.id 
      )
      
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "Customer associated with CustomerId must not be in deleted state",
        :phase_id =>  create_phase.id ,
        :project_id => project.id 
      )
      
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "TypeId must be present ",
        :phase_id =>  create_phase.id ,
        :project_id => project.id 
      )
      
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "Type associated with TypeId must not be in deleted state",
        :phase_id =>  create_phase.id ,
        :project_id => project.id 
      )

      Condition.create_object(
        :case => SPEC_CASE[:post],
        :description => "Auto create CreatedAt = DateTime.now",
        :phase_id =>  create_phase.id ,
        :project_id => project.id 
      )
      
      Condition.create_object(
        :case => SPEC_CASE[:post],
        :description => "Code= Auto generated with format: Customer.Id/year_created_at/month_created_at/total_item_in_that_year",
        :phase_id =>  create_phase.id ,
        :project_id => project.id 
      )
  
    update_phase = Phase.create_object(
      :name => "Update",
      :description => "Update object",
      :part_id => item_entity.id 
    )
  
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "If there are maintenances, can't update TypeId",
        :phase_id =>  update_phase.id ,
        :project_id => project.id 
      )
      
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "Can't Update CustomerId",
        :phase_id =>  update_phase.id ,
        :project_id => project.id 
      )

      Condition.create_object(
        :case => SPEC_CASE[:post],
        :description => "Auto create CreatedAt = DateTime.now",
        :phase_id =>  update_phase.id ,
        :project_id => project.id 
      )
    
    destroy_phase = Phase.create_object(
      :name => "Destroy",
      :description => "Destroy object",
      :part_id => item_entity.id 
    )
  
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "Can't be destroyed if there is Maintenance associated with this Item",
        :phase_id =>  destroy_phase.id ,
        :project_id => project.id 
      )
      
      Condition.create_object(
        :case => SPEC_CASE[:post],
        :description => "DeletedAt = DateTime.now",
        :phase_id =>  destroy_phase.id ,
        :project_id => project.id 
      )
    
      Condition.create_object(
        :case => SPEC_CASE[:post],
        :description => "soft destroy: mark column IsDeleted to be true",
        :phase_id =>  destroy_phase.id ,
        :project_id => project.id 
      )
    
  
=begin
  Maintenance Entity used 
=end
  maintenance_entity = Part.create_object(
    :name => "Maintenance",
    :description =>  "Treatment given to the customer's item",
    :group_id => operation_group.id
  )
  
    create_phase = Phase.create_object(
      :name => "Create",
      :description => "Create object",
      :part_id => maintenance_entity.id 
    )
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "ItemId must be present and valid (valid means: really available in database, and belongs to the customer)",
        :phase_id =>  create_phase.id ,
        :project_id => project.id 
      )
      
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "CustomerId must be present and valid",
        :phase_id =>  create_phase.id ,
        :project_id => project.id 
      )
      
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "TypeId must be present and valid ",
        :phase_id =>  create_phase.id ,
        :project_id => project.id 
      )
      
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "UserId must be present and valid",
        :phase_id =>  create_phase.id ,
        :project_id => project.id 
      )
      
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "RequestDate must be present",
        :phase_id =>  create_phase.id ,
        :project_id => project.id 
      )
      
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "Complaint must be present",
        :phase_id =>  create_phase.id ,
        :project_id => project.id 
      )
      
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "Case must be present: Can only select Constant.Maintenance.Case.Scheduled and Constant.Maintenance.Case.Emergency",
        :phase_id =>  create_phase.id ,
        :project_id => project.id 
      )
      
      Condition.create_object(
        :case => SPEC_CASE[:post],
        :description => "Auto create CreatedAt= DateTime.now",
        :phase_id =>  create_phase.id ,
        :project_id => project.id 
      )
      
      Condition.create_object(
        :case => SPEC_CASE[:post],
        :description => "Code= Auto generated with format: Customer.Id/year_created_at/month_created_at/total_item_in_that_year",
        :phase_id =>  create_phase.id ,
        :project_id => project.id 
      )
  
    update_phase = Phase.create_object(
      :name => "Update",
      :description => "Update object",
      :part_id => maintenance_entity.id 
    )
  
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "Can't update if it is Finished",
        :phase_id =>  update_phase.id ,
        :project_id => project.id 
      )
      
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "ItemId must be present and valid (valid means: really available in database, and belongs to the customer)",
        :phase_id =>  update_phase.id ,
        :project_id => project.id 
      )

      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "Can't update Customer",
        :phase_id =>  update_phase.id ,
        :project_id => project.id 
      )
      
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "TypeId must be present and valid ",
        :phase_id =>  update_phase.id ,
        :project_id => project.id 
      )
      
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "UserId must be present and valid",
        :phase_id =>  update_phase.id ,
        :project_id => project.id 
      )
      
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "RequestDate must be present",
        :phase_id =>  update_phase.id ,
        :project_id => project.id 
      )
      
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "Complaint must be present",
        :phase_id =>  update_phase.id ,
        :project_id => project.id 
      )
      
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "Case must be present",
        :phase_id =>  update_phase.id ,
        :project_id => project.id 
      )
      
      Condition.create_object(
        :case => SPEC_CASE[:post],
        :description => "AutoCreate UpdatedAt= DateTime.now",
        :phase_id =>  update_phase.id ,
        :project_id => project.id 
      )
    
    diagnose_phase = Phase.create_object(
      :name => "Diagnose",
      :description => "Set object phase into Diagnosed ",
      :part_id => maintenance_entity.id 
    )

      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "Diagnosis must be present",
        :phase_id =>  diagnose_phase.id ,
        :project_id => project.id 
      )

      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "DiagnosisCase must be present. Possible value: All_OK, FIX_REQUIRED, REPLACEMENT_REQUIRED",
        :phase_id =>  diagnose_phase.id ,
        :project_id => project.id 
      )

      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "DiagnosisDate must be present",
        :phase_id =>  diagnose_phase.id ,
        :project_id => project.id 
      )

      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "Solution must be present",
        :phase_id =>  diagnose_phase.id ,
        :project_id => project.id 
      )

      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "SolutionCase must be present. Possible values: NORMAL, PENDING, SOLVED",
        :phase_id =>  diagnose_phase.id ,
        :project_id => project.id 
      )

      Condition.create_object(
        :case => SPEC_CASE[:post],
        :description => "IsDiagnosed set to be true",
        :phase_id =>  diagnose_phase.id ,
        :project_id => project.id 
      )
      
    undiagnose_phase = Phase.create_object(
      :name => "UnDiagnose",
      :description => "Cancel Diagnose object",
      :part_id => maintenance_entity.id 
    )

      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "Must be in diagnosed state (IsDiagnosed = true ) ",
        :phase_id =>  undiagnose_phase.id ,
        :project_id => project.id 
      )

      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "must not be in finished state (IsFinished = false)",
        :phase_id =>  undiagnose_phase.id ,
        :project_id => project.id 
      )



      Condition.create_object(
        :case => SPEC_CASE[:post],
        :description => "set IsDiagnosed = false",
        :phase_id =>  undiagnose_phase.id ,
        :project_id => project.id 
      )


    confirm_phase = Phase.create_object(
      :name => "Confirm",
      :description => "Confirm Maintenance",
      :part_id => maintenance_entity.id 
    )

      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "IsDiagnosed must to be true",
        :phase_id =>  confirm_phase.id ,
        :project_id => project.id 
      )

      Condition.create_object(
        :case => SPEC_CASE[:post],
        :description => "Set IsFinished to be true",
        :phase_id =>  confirm_phase.id ,
        :project_id => project.id 
      )
    
    unconfirm_phase = Phase.create_object(
      :name => "Confirm",
      :description => "Confirm Maintenance",
      :part_id => maintenance_entity.id 
    )

      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "must be in finished state",
        :phase_id =>  unconfirm_phase.id ,
        :project_id => project.id 
      )

      Condition.create_object(
        :case => SPEC_CASE[:post],
        :description => "Set IsFinished to be false",
        :phase_id =>  unconfirm_phase.id ,
        :project_id => project.id 
      )
    
    destroy_phase = Phase.create_object(
      :name => "Destroy",
      :description => "Destroy object",
      :part_id => maintenance_entity.id 
    )
  
      Condition.create_object(
        :case => SPEC_CASE[:pre],
        :description => "can't be destroyed if it is finished or Diagnosed",
        :phase_id =>  destroy_phase.id ,
        :project_id => project.id 
      )
      
      Condition.create_object(
        :case => SPEC_CASE[:post],
        :description => "DeletedAt = DateTime.now",
        :phase_id =>  destroy_phase.id ,
        :project_id => project.id 
      )
    
      Condition.create_object(
        :case => SPEC_CASE[:post],
        :description => "soft destroy: mark column IsDeleted to be true",
        :phase_id =>  destroy_phase.id ,
        :project_id => project.id 
      )
    
  
  
  
  
  