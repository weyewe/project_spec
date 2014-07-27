class Api::GroupsController < Api::BaseApiController
  
  def index
    
    if params[:livesearch].present? 
      livesearch = "%#{params[:livesearch]}%"
      @objects = Group.active_objects.where{
        (is_deleted.eq false) & 
        (
          (name =~  livesearch )  
        )
        
      }.page(params[:page]).per(params[:limit]).order("id DESC")
      
      @total = Group.active_objects.where{
        (is_deleted.eq false) & 
        (
          (name =~  livesearch ) 
        )
        
      }.count
    elsif params[:parent_id].present?
      # @group_loan = GroupLoan.find_by_id params[:parent_id]
      @objects = Group.active_objects.
                  where(:project_id => params[:parent_id]).
                  page(params[:page]).per(params[:limit]).order("id DESC")
      @total = Group.active_objects.where(:project_id => params[:parent_id]).count 
    else
      @objects = Group.active_objects.page(params[:page]).per(params[:limit]).order("id DESC")
      @total = Group.active_objects.count
    end
    
    
    
    # render :json => { :groups => @objects , :total => @total, :success => true }
  end

  def create
    @object = Group.create_object( params[:group] )  
    
    
 
    if @object.errors.size == 0 
      render :json => { :success => true, 
                        :groups => [@object] , 
                        :total => Group.active_objects.count }  
    else
      msg = {
        :success => false, 
        :message => {
          :errors => extjs_error_format( @object.errors )  
        }
      }
      
      render :json => msg                         
    end
  end

  def update
    
    @object = Group.find_by_id params[:id] 
    @object.update_object( params[:group])
     
    if @object.errors.size == 0 
      render :json => { :success => true,   
                        :groups => [@object],
                        :total => Group.active_objects.count  } 
    else
      msg = {
        :success => false, 
        :message => {
          :errors => extjs_error_format( @object.errors )  
        }
      }
      
      render :json => msg 
    end
  end

  def destroy
    @object = Group.find(params[:id])
    @object.delete_object

    if @object.is_deleted
      render :json => { :success => true, :total => Group.active_objects.count }  
    else
      
      msg = {
        :success => false, 
        :message => {
          :errors => extjs_error_format( @object.errors )  
        }
      }
      
      render :json => msg
      
    end
  end
  
  def search
    search_params = params[:query]
    selected_id = params[:selected_id]
    if params[:selected_id].nil?  or params[:selected_id].length == 0 
      selected_id = nil
    end
    
    query = "%#{search_params}%"
    # on PostGre SQL, it is ignoring lower case or upper case 
    
    if  selected_id.nil?
      @objects = Group.active_objects.where{ (name =~ query)   
                              }.
                        page(params[:page]).
                        per(params[:limit]).
                        order("id DESC")
                        
      @total = Group.active_objects.where{ (name =~ query)  
                              }.count
    else
      @objects = Group.active_objects.where{ (id.eq selected_id)  
                              }.
                        page(params[:page]).
                        per(params[:limit]).
                        order("id DESC")
   
      @total = Group.active_objects.where{ (id.eq selected_id)   
                              }.count 
    end
    
    
    render :json => { :records => @objects , :total => @total, :success => true }
  end
end
