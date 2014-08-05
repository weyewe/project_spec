pdf.text "PnBit", size: 18, style: :bold, align: :center
pdf.text 'Functional Specification Document', size: 14, style: :bold_italic, align: :center

pdf.text "#{project.name}", size: 14, style: :bold, align: :center

pdf.text "for #{project.customer.name}", size: 14, style: :bold , align: :center

pdf.text "#{project.description}", style: :italic, align: :center
pdf.text "\n\n"

pdf.text "Part: #{part.name} [#{part.code}]", size: 12 

pdf.text "Total Phases: #{part.phases.count}", size: 12 

pdf.text "Total PreCondition: #{part.pre_conditions_count}", size: 12 
pdf.text "Total PostCondition: #{part.post_conditions_count}", size: 12 

pdf.text "\n\n"

# pdf.start_new_page
