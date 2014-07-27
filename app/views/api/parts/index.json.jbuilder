json.success true 
json.total @total
json.parts @objects do |object|
	json.id 								object.id  
 	json.group_id 			object.group.id
	json.group_name 			object.group.name 
	
	json.code	object.code
	json.name	object.name
	json.description	object.description
	 


	
end


