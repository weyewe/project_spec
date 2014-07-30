pdf.text "PnBit", size: 18, style: :bold, align: :center
pdf.text 'Functional Specification Document', size: 14, style: :bold_italic, align: :center


pdf.move_down 40
pdf.text "#{project.name}", size: 18, style: :bold, align: :center

pdf.move_down 40
pdf.text "for #{project.customer.name}", size: 14, style: :bold , align: :center

pdf.move_down 40
pdf.text "#{project.description}", style: :italic, align: :center



# 612.00 x 936.00
# 


pdf.formatted_text_box([  {:text => "Last Print: #{Time.now.strftime("%Y-%m-%d")}\n"+
                                "Total Entity: 40\n" +
 																"Total PreCondition: 200\n" + 
																"Total PostCondition: 300",
                       :size => 12}
                  ],   :at => [390, pdf.cursor - 620 + 120])

pdf.start_new_page
