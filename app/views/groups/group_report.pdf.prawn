prawn_document( :force_download=>true, :page_size => "FOLIO") do |pdf|
	render "frontpage", :pdf => pdf, :project => @project , :group => @group 
	
	
	part_counter = 0 
	total_parts = @group.parts.where(:is_deleted => false).count 
	@group.parts.where(:is_deleted => false).order("id ASC").each do |part|
		render "part", :pdf => pdf, :part => part , 
							:counter => part_counter, :group => @group, :total_parts => total_parts 
		part_counter +=1 
	end
	
	
	
	pdf.number_pages "<page> / <total>", 
	                                       {:start_count_at => 1,
	                                        # :page_filter => lambda{ |pg| pg != 1 },
	                                        :at => [pdf.bounds.right - 100, 20],
	                                        :align => :right,
	                                        :size => 10}
 





end
