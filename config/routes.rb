Ticketie::Application.routes.draw do
  devise_for :users
  root :to => 'home#index'
  
  resources :projects 
  get 'projects_basic' => 'projects#basic', :as => :projects_basic, :method => :get
  get 'module_pdf/:id' => 'groups#group_report' , :as => :groups_pdf, :method => :get
  get 'projects_pdf/:id' => 'projects#pdf_report' , :as => :projects_pdf, :method => :get
  get 'entity_pdf/:id' => 'parts#part_report' , :as => :parts_pdf, :method => :get
  get 'phase_pdf/:id' => 'phases#phase_report' , :as => :phases_pdf, :method => :get
  
  
  namespace :api do
    devise_for :users
    post 'authenticate_auth_token', :to => 'sessions#authenticate_auth_token', :as => :authenticate_auth_token 
    put 'update_password' , :to => "passwords#update" , :as => :update_password
    get 'search_role' => 'roles#search', :as => :search_role, :method => :get
    get 'search_user' => 'app_users#search', :as => :search_user, :method => :get
    get 'search_type' => 'types#search', :as => :search_type, :method => :get
    get 'search_item' => 'items#search', :as => :search_item, :method => :get
    get 'search_project' => 'projects#search', :as => :search_project, :method => :get
    get 'search_group' => 'groups#search', :as => :search_group, :method => :get
    get 'search_part' => 'parts#search', :as => :search_part, :method => :get
    get 'search_phase' => 'phases#search', :as => :search_phase, :method => :get
    get 'search_spec' => 'specs#search', :as => :search_spec, :method => :get
    
    get 'search_customer' => 'customers#search', :as => :search_customer, :method => :get
    
    get 'search_pre_condition' => 'pre_conditions#search', :as => :search_pre_condition, :method => :get
    get 'search_post_condition' => 'post_conditions#search', :as => :search_post_condition, :method => :get
    
    
    # master data 
    resources :app_users
    resources :customers 
    resources :types  
    resources :items 
    resources :contract_maintenances 
    resources :contract_items 
    
    # for the project_spec
    resources :projects 
    resources :groups 
    resources :parts
    resources :phases
    resources :specs
    resources :pre_specs
    resources :post_specs
    resources :pre_conditions
    resources :post_conditions 
    
    
  end
  
  
end
