class ProjectConfigurationController < ApplicationController

  before_action :find_project_by_project_id, :only => [:index, :save]

  def index
    @configuration = ProjectConfiguration.find(@project.identifier)
    render :action => 'save'
  end

  def save
    configuration = ProjectConfiguration.find(params[:project_id])
    if configuration
      configuration.scm_url = params[:scm_url]
      configuration.bug_tracker = params[:bug_tracker]

      if configuration.save
        flash[:notice] = 'Configuration saved.'
      end
    else
      ProjectConfiguration.create(
        project_id: params[:project_id],
        scm_url: params[:scm_url],
        bug_tracker: params[:bug_tracker]
      )
    end

  end
end
