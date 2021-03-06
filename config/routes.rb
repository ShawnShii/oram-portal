Rails.application.routes.draw do
  resources :notes
  root 'welcome#index'
  devise_for :admins, :controllers => { :invitations => 'admins/invitations' }
  devise_for :users, :controllers => { :invitations => 'users/invitations'}

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  get 'users/:id' => 'users#show'
  get 'admins' => 'admins#show_all', :as => 'admins'
  get 'admins/:id' => 'admins#show', :as => 'admin'
  get 'admins/:id/profile' => 'admins#show_my_profile', :as => 'show_my_profile'
  get 'admins/:id/setting' => 'admins#admin_setting', :as => 'admin_setting'
  get 'admins/:id/setting/edit' => 'admins#admin_settings_edit', :as => 'admin_settings_edit'
  get 'admins/:id/setting/delete' => 'admins#admin_destroy', :as => 'admin_destroy'
  patch 'admins/:id/setting' => 'admins#admin_edit_save', :as => 'edit_save_admin'
  get 'admins/:id/setting/change_password' => 'admins#admin_pass_change', :as => 'admin_pass_change'
  patch 'admins/:id/setting/password' => 'admins#admin_pass_save', :as => 'admin_pass_save'

  get 'clients' => 'admins#show_clients', :as => 'clients'
  get 'referrals' => 'admins#show_referrals', :as => 'admin_referrals'

  get 'referrers' => 'admins#show_referrers', :as => 'referrers'
  get 'referrers/:id/referrals' => 'users#referrals', :as => 'referrals'
  get 'referrers/:id/edit' => 'users#edit_referrer_profile', :as => 'referrer_edit'
  get 'referrer/:id' => 'users#show', :as => 'referrer'
  put 'referrers/:id' => 'users#update_referrer_profile', :as => 'referrer_update'
  post 'referrers/:id/update_status' => 'admins#mark_referrer_status', :as => 'mark_referrer_status'
  
  get 'referrers/:id/profile' => 'admins#show_my_profile', :as => 'my_profile'
  get 'referrers/:id/setting' => 'admins#admin_setting', :as => 'settings'
  get 'referrers/:id/setting/edit' => 'admins#admin_settings_edit', :as => 'settings_edit'
  get 'referrers/:id/setting/delete' => 'admins#admin_destroy', :as => 'destroy'
  patch 'referrers/:id/setting' => 'admins#admin_edit_save', :as => 'save'
  get 'referrers/:id/setting/change_password' => 'admins#admin_pass_change', :as => 'pass_change'
  patch 'referrers/:id/setting/password' => 'admins#admin_pass_save', :as => 'pass_save'

  get 'referrers/:id/refer_client' => 'users#refer_client', :as => 'refer_client'
  post 'referrers/:id/create_referral' => 'users#create_referral', :as => 'create_referral'

  get 'clients/:id' => 'users#show', :as => "client"
  get 'clients/:id/edit' => 'users#edit_client_profile', :as => 'client_edit'
  put 'clients/:id' => 'users#update_client_profile', :as => 'client_update'
  post 'clients/:id/update_status' => 'admins#mark_client_status', :as => 'mark_client_status'
  post 'clients/:id/update_phase' => 'admins#change_client_phase', :as => 'admin_change_client_phase'
  post 'clients/:id/assign_caseworker' => 'admins#assign_caseworker', :as => 'admin_assign_caseworker'
  put  'notes/:id' => 'notes#update', :as => 'note_update'
  post '/notes' => 'notes#create', :as => 'note_create'
  delete '/notes/:id' => 'notes#destroy', :as => 'note_destroy'
  
  post 'clients/:id/delete_caseworker' => 'admins#delete_caseworker', :as => 'admin_delete_caseworker'
  
  get 'referrals/:id' => 'forms#show', :as => 'referral'
  post 'referrals/:id/update_status' => 'admins#mark_form_status', :as => 'mark_form_status'

  # get 'clients/:id/documents' => 'users#client_documents', :as => 'documents'
  # post 'clients/:id/documents' => 'users#upload_document', :as => 'upload'
  
  get 'users/:id/setting' => 'users#user_setting', :as => 'user_setting'
  get 'users/:id/setting/edit' => 'users#user_settings_edit', :as => 'user_settings_edit'
  get 'users/:id/setting/delete' => 'users#user_destroy', :as => 'user_destroy'
  patch 'users/:id/setting' => 'users#user_edit_save', :as => 'edit_save'
  get 'users/:id/setting/change_password' => 'users#user_pass_change', :as => 'user_pass_change'
  patch 'users/:id/setting/password' => 'users#user_pass_save', :as => 'user_pass_save'
  # get 'referrer/:id/setting' => 'users#user_setting', :as => 'referrer_setting'
  get 'referrer/:id/case_status' => 'users#case_status', :as => 'case_status'
  
  
  #For uploading documents
  get 'clients/:id/updocs/' =>'updocs#index', :as => 'updocs'
  post 'clients/:id/updocs/' =>'updocs#create'
  get 'clients/:id/updocs/new' =>'updocs#new', :as => 'new_updocs'
  delete 'clients/:id/updocs/:doc_id' =>'updocs#destroy', :as => 'updoc'
  # get '/' => 'updoc#index', :as => 'root'
  get 'clients/:id/updocs/index' =>'updocs#index', :as => 'updocs_index'
  get 'clients/:id/updocs/new' =>'updocs#new', :as => 'updocs_new'
  get 'clients/:id/updocs/create' =>'updocs#create', :as => 'updocs_create'
  get 'clients/:id/updocs/destroy' =>'updocs#destroy', :as => 'updocs_destroy'
  
  get '/pending' => 'admins#show_pending', :as => 'pending'

  #For connecting to the Google Calendar API
  get 'clients/:id/redirect', to: 'calendars#redirect', as: 'calendar_redirect'
  get 'callback', to: 'calendars#callback', as: 'calendar_callback'
  get 'clients/:id/calendars', to: 'calendars#calendars', as: 'calendars'
  post 'clients/:id/calendars', to: 'calendars#set_calendar', as: 'set_calendar'
  delete 'clients/:id', to: 'calendars#delete', as: 'calendar_delete'

end
