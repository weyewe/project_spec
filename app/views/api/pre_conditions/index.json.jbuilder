json.success true 
json.total @total
json.pre_conditions @objects do |object|
	json.id 								object.id  
 	json.phase_id 			object.phase.id
	json.phase_name 			object.phase.name 
	
	json.code	object.code
	json.description	object.description
	 


	
end


