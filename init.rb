require_relative './patches/project_settings_tabs_patch'
require_relative './patches/project'
require_relative './lib/scmm_hook_listener'

Redmine::Plugin.register :scm_manager do
  name 'SCM-Manager Plugin'
  author 'Cloudogu GmbH'
  description 'Integration for SCM-Manager into Redmine'
  version '0.0.1'
  url 'https://scm-manager.org/'
  author_url 'https://cloudogu.com/'

  project_module :scm_manager do
    permission :project_configuration, { :project_configuration => [:create, :update] }
  end

  Rails.configuration.to_prepare do
    ScmmPlugin::ProjectSettingsTabsPatch.apply
    ScmmPlugin::ProjectPatch.apply
  end

end

Redmine::MenuManager.map :issue_sidebar_more_menu do |menu|
  menu.push :new_scmm_issue_connected_branch, -> issue { new_scmm_issue_connected_branch_path(issue_id: issue.id) },
            caption: :scmm_create_connection,
            html: {
              class: 'button icon icon-relation',
              title: :scmm_create_connection
            },
            if: -> issue { User.current.allowed_to?(:manage_issue_relations, issue.project) }
end
