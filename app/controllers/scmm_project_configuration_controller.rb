class ScmmProjectConfigurationController < ApplicationController

  before_action :set_configuration, only: [:update]
  before_action :authorize

  def create
    @project_configuration = ScmmProjectConfiguration.create(
      configuration_params
        .merge(project_id: params[:id])
    )
    respond_to do |format|
      format.html { redirect_to :back, notice: l("scmm_configuration_saved") }
      format.json { head :no_content }
    end
  end

  def update
    @project_configuration.update(configuration_params)
    respond_to do |format|
      format.html { redirect_to :back, notice: l("scmm_configuration_saved") }
      format.json { head :no_content }
    end
  end

  private

  def set_configuration
    @project_configuration = ScmmProjectConfiguration.find(params[:id])
  end

  def configuration_params
    params.require(:scmm_project_configuration).permit(:scm_url, :bug_tracker)
  end
end
