require_relative './patches/project_settings_tabs_patch'
require_relative './patches/project'

Redmine::Plugin.register :scm_manager do
  name 'SCM-Manager Plugin'
  author 'Cloudogu GmbH'
  description 'Integration for SCM-Manager into Redmine'
  version '0.0.1'
  url 'https://scm-manager.org/'
  author_url 'https://cloudogu.com/'

  project_module :scm_manager do
    permission :project_configuration, { :project_configuration => [:index, :save] }
  end

  Rails.configuration.to_prepare do
    ScmmPlugin::ProjectSettingsTabsPatch.apply
    ScmmPlugin::ProjectPatch.apply
  end

end
