pdf.text "#{counter}. #{group.name} [#{group.code}]\n\n", size: 18, style: :bold, align: :center
pdf.text "#{group.description}", size: 12, style: :italic, align: :left


pdf.move_down 20


pdf.text "Entity used in this group:", size: 12,  align: :left
group.parts.where(:is_deleted => false).order("id ASC").each do |part|
	pdf.text "#{part.code}. #{part.name}", size: 12, style: :bold, align: :left
	
	pdf.text "#{part.description}\n\n", size: 12, align: :left
end

pdf.start_new_page


part_counter = 1
total_parts = group.parts.where(:is_deleted => false).count 
group.parts.where(:is_deleted => false).order("id ASC").each do |part|
	render "part", :pdf => pdf, :part => part , 
						:counter => part_counter, :group => group, :total_parts => total_parts 
	part_counter +=1 
end


pdf.start_new_page if counter != group_length 