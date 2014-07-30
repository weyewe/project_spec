prawn_document( :force_download=>true, :page_size => "FOLIO") do |pdf|
	render "frontpage", :pdf => pdf, :project => @project 
	
	
	counter = 1
	@groups.each do |group|
		render "group", :pdf => pdf, :project => @project , :counter => counter, :group => group 
		counter +=1 
	end
	
	
 





end
