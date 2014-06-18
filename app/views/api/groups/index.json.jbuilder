json.success true 
json.total @total
json.groups @objects do |object|
	json.id 								object.id  
 	json.project_id 			object.project.id
	json.project_name 			object.project.name 
	
	json.code	object.code
	json.name	object.name
	json.description	object.description
	 


	
end


