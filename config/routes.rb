# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
resources :projects do
  resources :scmm_project_configuration, only: [:create, :update]
end

resources :issues do
  resources :scmm_issue_connected_branches, only: [:new, :create, :destroy]
end