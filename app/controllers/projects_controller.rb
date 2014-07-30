class ProjectsController < ApplicationController
  
  def basic
  end
  
  def pdf_report
    @project = Project.find_by_id params[:id]
    @groups = @project.groups.includes(:parts => [:phases => [:conditions]])
  end
  
  
  def show
    puts "3321 this is in Projects#show action\n"*10
    
    @project = Project.find_by_id params[:id]
    @groups = @project.groups.joins(:parts => [:phases => [:conditions]])
    # puts "@project = #{@project.inspect}\n\n"
    # 
    # puts "@groups  = #{@groups.inspect}"
    # # pdf = FinalReport.new(@project, @groups)
    # 
    # 
    # pdf = Prawn::Document.generate("test.pdf") do |pdf|
    #      table_data = [[Prawn::Table::Cell::Text.new( pdf, [0,0], :content => "<b>1. Row example text</b> \n\nExample Text Not Bolded", :inline_format => true), "433"],
    #                    [Prawn::Table::Cell::Text.new( pdf, [0,0], :content => "<b>2. Row example text</b>", :inline_format => true), "2343"],
    #                    [Prawn::Table::Cell::Text.new( pdf, [0,0], :content => "<b>3. Row example text</b>", :inline_format => true), "342"],                    
    #                    [Prawn::Table::Cell::Text.new( pdf, [0,0], :content => "<b>4. Row example text</b>", :inline_format => true), "36"]]
    # 
    #     pdf.table(table_data,:width => 500)
    # end
    # 
    # 
    # respond_to do |format|
    #   format.html do
    #     render :layout => false 
    #   end
    #   
    #   
    #   format.pdf do
    #     send_data pdf.render, 
    #               filename: 'summary_report.pdf', 
    #               type: 'application/pdf', 
    #               disposition: 'inline'
    #     
    #     
    #     # pdf = PaymentPdf.new(@project, view_context )
    #     #         send_data pdf.render, filename:
    #     #         "#{DateTime.now.to_s}.pdf",
    #     #         type: "application/pdf"
    #     
    #     
    #     # pdf = Prawn::Document.new
    #     # pdf.define_grid(:columns => 6, :rows => 8, :gutter => 10)
    #     # 
    #     # # Helper method to showcase the positioning of all grid cells
    #     # pdf.grid.show_all
    #     # 
    #     # # New blank canvas for another example
    #     # pdf.start_new_page
    #     # 
    #     # pdf.grid([2,2], [4,4]).bounding_box do
    #     #   pdf.move_down 100
    #     #   pdf.text "We can write text inside grid elements or any other shape"
    #     # end
    #     # 
    #     # # to help visualize the grid position, show the outline
    #     # pdf.grid([2,2],[4,4]).show
    #     # 
    #     # send_data pdf.render, :filename => "x.pdf", :type => "application/pdf", :disposition => 'inline'
    #     # 
    #   end
    #   
    #   
    #   
    #
    # end
  end
end
