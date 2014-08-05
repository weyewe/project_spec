prawn_document( :force_download=>true, :page_size => "FOLIO") do |pdf|
	render "frontpage", :pdf => pdf, :project => @project , :part => @part 
	
	
	counter = 1
	@phases.each do |phase|
		render "phase", :pdf => pdf, :project => @project ,  :part => @part ,
		 		:counter => counter, :phase => phase , :phase_length => @phases.length
		counter +=1 
	end
	
	
	
	pdf.number_pages "<page> / <total>", 
	                                       {:start_count_at => 1,
	                                        # :page_filter => lambda{ |pg| pg != 1 },
	                                        :at => [pdf.bounds.right - 100, 20],
	                                        :align => :right,
	                                        :size => 10}
 





end
