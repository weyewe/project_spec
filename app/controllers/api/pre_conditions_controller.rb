class Api::PreConditionsController < Api::BaseApiController
  
  def index
    
    if params[:livesearch].present? 
      livesearch = "%#{params[:livesearch]}%"
      @objects = Condition.active_objects.where(:case => SPEC_CASE[:pre]).where{
        (is_deleted.eq false) & 
        (
          (code =~  livesearch )  
        )
        
      }.page(params[:page]).per(params[:limit]).order("id DESC")
      
      @total = Condition.active_objects.where(:case => SPEC_CASE[:pre]).where{
        (is_deleted.eq false) & 
        (
          (code =~  livesearch ) 
        )
        
      }.count
    else
      @objects = Condition.active_objects.where(:case => SPEC_CASE[:pre]).page(params[:page]).per(params[:limit]).order("id DESC")
      @total = Condition.active_objects.where(:case => SPEC_CASE[:pre]).count
    end
    
    
    
    # render :json => { :conditions => @objects , :total => @total, :success => true }
  end

  def create
    params[:condition][:case] = SPEC_CODE[:pre]
    @object = Condition.create_object( params[:condition] )  
    
    
 
    if @object.errors.size == 0 
      render :json => { :success => true, 
                        :conditions => [@object] , 
                        :total => Condition.active_objects.where(:case => SPEC_CASE[:pre]).count }  
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
    
    @object = Condition.find_by_id params[:id] 
    @object.update_object( params[:condition])
     
    if @object.errors.size == 0 
      render :json => { :success => true,   
                        :conditions => [@object],
                        :total => Condition.active_objects.where(:case => SPEC_CASE[:pre]).count  } 
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
    @object = Condition.find(params[:id])
    @object.delete_object

    if @object.is_deleted
      render :json => { :success => true, :total => Condition.active_objects.where(:case => SPEC_CASE[:pre]).count }  
    else
      render :json => { :success => false, :total => Condition.active_objects.where(:case => SPEC_CASE[:pre]).count }  
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
      @objects = Condition.active_objects.where(:case => SPEC_CASE[:pre]).where{ (code =~ query)   
                              }.
                        page(params[:page]).
                        per(params[:limit]).
                        order("id DESC")
                        
      @total = Condition.active_objects.where(:case => SPEC_CASE[:pre]).where{ (code =~ query)  
                              }.count
    else
      @objects = Condition.active_objects.where{ (id.eq selected_id)  
                              }.
                        page(params[:page]).
                        per(params[:limit]).
                        order("id DESC")
   
      @total = Condition.active_objects.where(:case => SPEC_CASE[:pre]).where{ (id.eq selected_id)   
                              }.count 
    end
    
    
    render :json => { :records => @objects , :total => @total, :success => true }
  end
end
