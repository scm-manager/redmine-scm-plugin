class ProjectConfigurationController < ApplicationController

  before_action :set_configuration, only: [:update]

  def create
    @project_configuration = ProjectConfiguration.create(
      configuration_params
        .merge(project_id: params[:id])
    )
  end

  def update
    @project_configuration.update(configuration_params)
  end

  private

  def set_configuration
    @project_configuration = ProjectConfiguration.find(params[:id])
  end

  def configuration_params
    params.require(:project_configuration).permit(:scm_url, :bug_tracker)
  end
end
