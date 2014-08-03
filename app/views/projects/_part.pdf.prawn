# part has_many phases. Phases has_many condition (precondition + post condition)

pdf.text "#{part.code}. #{part.name}\n\n", size: 18, style: :bold, align: :center
pdf.text "Total phases: #{part.phases.where(:is_deleted => false).count}\n\n", size: 12, style: :bold, align: :center


part.phases.where(:is_deleted => false).order("id ASC").each do |phase|
	pdf.text "#{phase.code}. #{phase.name}\n\n", size: 12, style: :bold 
	
	
	pdf.text "PreCondition", size: 12   
	data = []
	data << [
		"Code",
		"Description"
	]
	
	phase.pre_conditions.where(:is_deleted => false).each do |condition|
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
	
	phase.post_conditions.where(:is_deleted => false).each do |condition|
		data  << [condition.code, condition.description]
	end
	
	pdf.table( data ) do
		column(0).style(:width => 200, :height => 24 )
		row(0).font_style = :bold
	end
	
	pdf.text "\n\n"
	 
end



# spec code, description 

pdf.start_new_page if counter != total_parts


 