pdf.text "PnBit", size: 18, style: :bold, align: :center
pdf.text 'Functional Specification Document', size: 14, style: :bold_italic, align: :center

pdf.text "#{project.name}", size: 14, style: :bold, align: :center

pdf.text "for #{project.customer.name}", size: 14, style: :bold , align: :center

pdf.text "#{project.description}", style: :italic, align: :center
pdf.text "\n\n"

pdf.text "Group: #{group.name} [#{group.code}]", size: 12 
pdf.text "Description: #{group.description} [#{group.code}]", size: 12 

pdf.text "Total Parts: #{group.parts.where(:is_deleted => false).count}]", size: 12 , style: :bold

pdf.text "Total PreCondition: #{group.pre_conditions_count}", size: 12 
pdf.text "Total PostCondition: #{group.post_conditions_count}", size: 12 

pdf.text "\n\n"

# pdf.start_new_page
