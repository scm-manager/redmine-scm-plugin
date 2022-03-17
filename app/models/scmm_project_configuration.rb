class ScmmProjectConfiguration < ActiveRecord::Base
  self.primary_key = :project_id
  belongs_to :project
end
