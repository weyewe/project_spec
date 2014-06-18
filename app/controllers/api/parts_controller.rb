class Api::PartsController < Api::BaseApiController
  
  def index
    
    if params[:livesearch].present? 
      livesearch = "%#{params[:livesearch]}%"
      @objects = Part.active_objects.where{
        (is_deleted.eq false) & 
        (
          (name =~  livesearch )  
        )
        
      }.page(params[:page]).per(params[:limit]).order("id DESC")
      
      @total = Part.active_objects.where{
        (is_deleted.eq false) & 
        (
          (name =~  livesearch ) 
        )
        
      }.count
    else
      @objects = Part.active_objects.page(params[:page]).per(params[:limit]).order("id DESC")
      @total = Part.active_objects.count
    end
    
    
    
    # render :json => { :parts => @objects , :total => @total, :success => true }
  end

  def create
    @object = Part.create_object( params[:part] )  
    
    
 
    if @object.errors.size == 0 
      render :json => { :success => true, 
                        :parts => [@object] , 
                        :total => Part.active_objects.count }  
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
    
    @object = Part.find_by_id params[:id] 
    @object.update_object( params[:part])
     
    if @object.errors.size == 0 
      render :json => { :success => true,   
                        :parts => [@object],
                        :total => Part.active_objects.count  } 
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
    @object = Part.find(params[:id])
    @object.delete_object

    if @object.is_deleted
      render :json => { :success => true, :total => Part.active_objects.count }  
    else
      render :json => { :success => false, :total => Part.active_objects.count }  
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
      @objects = Part.active_objects.where{ (name =~ query)   
                              }.
                        page(params[:page]).
                        per(params[:limit]).
                        order("id DESC")
                        
      @total = Part.active_objects.where{ (name =~ query)  
                              }.count
    else
      @objects = Part.active_objects.where{ (id.eq selected_id)  
                              }.
                        page(params[:page]).
                        per(params[:limit]).
                        order("id DESC")
   
      @total = Part.active_objects.where{ (id.eq selected_id)   
                              }.count 
    end
    
    
    render :json => { :records => @objects , :total => @total, :success => true }
  end
end
