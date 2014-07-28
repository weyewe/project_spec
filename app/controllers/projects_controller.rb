class ProjectsController < ApplicationController
  def show
    
    @project = Project.find_by_id params[:id]
    respond_to do |format|
      format.html do
        render :layout => false 
      end
      format.pdf do
        pdf = PaymentPdf.new(@project, view_context )
        send_data pdf.render, filename:
        "#{DateTime.now.to_s}.pdf",
        type: "application/pdf"
      end
      
      
    end
  end
end
