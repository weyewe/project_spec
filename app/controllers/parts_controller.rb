class PartsController < ApplicationController
  
  def basic
  end
  
  def part_report
    
    @part = Part.find_by_id(params[:id]) 
    @project = @part.group.project 
    @phases = @part.phases.includes(:conditions).where(:is_deleted => false).order("id ASC")
  end
   
end
