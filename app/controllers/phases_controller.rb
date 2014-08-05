class PhasesController < ApplicationController
  
  def basic
  end
  
  def phase_report
    @phase = Phase.find_by_id params[:id]
    @part = @phase.part 
    @project = @part.group.project 
  end
   
end
