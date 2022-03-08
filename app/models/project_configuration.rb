class ProjectConfiguration < ActiveRecord::Base
  self.primary_key = :project_id
  attr_accessor :scm_url, :bug_tracker
end
