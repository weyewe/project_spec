prawn_document( :force_download=>true, :page_size => "FOLIO") do |pdf|
	render "frontpage", :pdf => pdf, :project => @project , :part => @part , :phase => @phase 
	
 

	pdf.text "PreCondition", size: 12   
	data = []
	data << [
		"Code",
		"Description"
	]

	@phase.pre_conditions.where(:is_deleted => false).each do |condition|
		data  << [condition.code, condition.description]
	end

	pdf.table( data ) do
		column(0).style(:width => 200, :height => 24)
		row(0).font_style = :bold
	end








	pdf.text "\n\nPostCondition", size: 12   
	data = []
	data << [
		"Code",
		"Description"
	]

	@phase.post_conditions.where(:is_deleted => false).each do |condition|
		data  << [condition.code, condition.description]
	end

	pdf.table( data ) do
		column(0).style(:width => 200, :height => 24 )
		row(0).font_style = :bold
	end
	
	
	
	pdf.number_pages "<page> / <total>", 
	                                       {:start_count_at => 1,
	                                        # :page_filter => lambda{ |pg| pg != 1 },
	                                        :at => [pdf.bounds.right - 100, 20],
	                                        :align => :right,
	                                        :size => 10}
 





end
