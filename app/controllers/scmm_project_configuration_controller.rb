class ScmmProjectConfigurationController < ApplicationController

  before_action :find_project_by_project_id, :authorize, :set_configuration

  def update
    cleaned_configuration = clean_configuration
    @project_configuration.update(cleaned_configuration)
    respond_to do |format|
      format.html { redirect_to :back, notice: l("scmm_configuration_saved") }
      format.json { head :no_content }
    end
  end

  private

  def clean_configuration
    cleaned_scm_url = configuration_params[:scm_url]
    while cleaned_scm_url.end_with? '/'
      cleaned_scm_url = cleaned_scm_url[0..cleaned_scm_url.length - 2]
    end
    cleaned_bug_tracker = configuration_params[:bug_tracker]
    cleaned_bug_tracker.strip!
    {
      :scm_url => cleaned_scm_url,
      :bug_tracker => cleaned_bug_tracker
    }
  end

  def set_configuration
    @project_configuration = ScmmProjectConfiguration.find(params[:id])
  end

  def configuration_params
    params.require(:scmm_project_configuration).permit(:scm_url, :bug_tracker)
  end
end
