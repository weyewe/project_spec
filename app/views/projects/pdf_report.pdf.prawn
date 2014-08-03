prawn_document( :force_download=>true, :page_size => "FOLIO") do |pdf|
	render "frontpage", :pdf => pdf, :project => @project 
	
	
	counter = 1
	@groups.each do |group|
		render "group", :pdf => pdf, :project => @project ,
		 		:counter => counter, :group => group , :group_length => @groups.length
		counter +=1 
	end
	
	
	
	pdf.number_pages "<page> / <total>", 
	                                       {:start_count_at => 1,
	                                        :page_filter => lambda{ |pg| pg != 1 },
	                                        :at => [pdf.bounds.right - 100, 20],
	                                        :align => :right,
	                                        :size => 10}
 





end
