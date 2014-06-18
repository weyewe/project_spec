
json.success true 
json.total @total
json.projects @objects do |object|
	json.id 								object.id  
 
	 
	json.name	object.name
	json.description	object.description
	
	json.customer_id object.customer.id
	json.customer_name object.customer.name 
	 


	
end


