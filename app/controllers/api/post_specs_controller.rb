class Api::PreSpecsController < Api::BaseApiController
  
  def index
    
    if params[:livesearch].present? 
      livesearch = "%#{params[:livesearch]}%"
      @objects = Spec.active_objects.where(:case => SPEC_CASE[:post]).where{
        (is_deleted.eq false) & 
        (
          (code =~  livesearch )  
        )
        
      }.page(params[:page]).per(params[:limit]).order("id DESC")
      
      @total = Spec.active_objects.where(:case => SPEC_CASE[:post]).where{
        (is_deleted.eq false) & 
        (
          (code =~  livesearch ) 
        )
        
      }.count
    else
      @objects = Spec.active_objects.where(:case => SPEC_CASE[:post]).page(params[:page]).per(params[:limit]).order("id DESC")
      @total = Spec.active_objects.where(:case => SPEC_CASE[:post]).count
    end
    
    
    
    # render :json => { :specs => @objects , :total => @total, :success => true }
  end

  def create
    params[:spec][:case] = SPEC_CODE[:post]
    @object = Spec.create_object( params[:spec] )  
    
    
 
    if @object.errors.size == 0 
      render :json => { :success => true, 
                        :specs => [@object] , 
                        :total => Spec.active_objects.where(:case => SPEC_CASE[:post]).count }  
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
    
    @object = Spec.find_by_id params[:id] 
    @object.update_object( params[:spec])
     
    if @object.errors.size == 0 
      render :json => { :success => true,   
                        :specs => [@object],
                        :total => Spec.active_objects.where(:case => SPEC_CASE[:post]).count  } 
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
    @object = Spec.find(params[:id])
    @object.delete_object

    if @object.is_deleted
      render :json => { :success => true, :total => Spec.active_objects.where(:case => SPEC_CASE[:post]).count }  
    else
      render :json => { :success => false, :total => Spec.active_objects.where(:case => SPEC_CASE[:post]).count }  
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
      @objects = Spec.active_objects.where(:case => SPEC_CASE[:post]).where{ (code =~ query)   
                              }.
                        page(params[:page]).
                        per(params[:limit]).
                        order("id DESC")
                        
      @total = Spec.active_objects.where(:case => SPEC_CASE[:post]).where{ (code =~ query)  
                              }.count
    else
      @objects = Spec.active_objects.where{ (id.eq selected_id)  
                              }.
                        page(params[:page]).
                        per(params[:limit]).
                        order("id DESC")
   
      @total = Spec.active_objects.where(:case => SPEC_CASE[:post]).where{ (id.eq selected_id)   
                              }.count 
    end
    
    
    render :json => { :records => @objects , :total => @total, :success => true }
  end
end
