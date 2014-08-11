class GroupsController < ApplicationController
  
  def basic
  end
  
  def group_report
    @group = Group.find_by_id params[:id]
    @project = @group.project
  end
   
end
