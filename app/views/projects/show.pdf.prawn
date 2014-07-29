prawn_document( :force_download=>true, :page_size => "FOLIO") do |pdf|
	render "frontpage", :pdf => pdf
	
	render "second_frontpage", :pdf => pdf, :awesome_variable => "This is awesome variable"


  pdf.text "Look! I'm landscape"
  pdf.text "And on legal paper too!"

	table_data = [[Prawn::Table::Cell::Text.new( pdf, [0,0], :content => "<b>1. Row example text</b> \n\nExample Text Not Bolded", :inline_format => true), "433"],
	[Prawn::Table::Cell::Text.new( pdf, [0,0], :content => "<b>2. Row example text</b>", :inline_format => true), "2343"],
	[Prawn::Table::Cell::Text.new( pdf, [0,0], :content => "<b>3. Row example text</b>", :inline_format => true), "342"],                    
	[Prawn::Table::Cell::Text.new( pdf, [0,0], :content => "<b>4. Row example text</b>", :inline_format => true), "36"]]

	pdf.table(table_data,:width => 500)
	
	pdf.start_new_page
	
	pdf.text "Second Page"
	pdf.table(table_data,:width => 500)


end
