json.success true 
json.total @total
json.phases @objects do |object|
	json.id 								object.id  
 	json.part_id 			object.part.id
	json.part_name 			object.part.name 
	
	json.code	object.code
	json.name	object.name
	json.description	object.description
	 


	
end


