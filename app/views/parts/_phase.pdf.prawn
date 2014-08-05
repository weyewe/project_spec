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