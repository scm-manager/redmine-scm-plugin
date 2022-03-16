require_relative './patches/project_settings_tabs_patch'
require_relative './patches/project_patch'
require_relative './patches/issue_patch'
require_relative './patches/menu_helper_patch'
require_relative './lib/hooks'

Redmine::Plugin.register :redmine_scmm_plugin do
  name :scmm_plugin_name
  author 'Cloudogu GmbH'
  description :scmm_plugin_description
  version '0.0.1'
  url 'https://scm-manager.org/'
  author_url 'https://cloudogu.com/'

  project_module :scm_manager do
    permission :scmm_configure_project, { :scmm_project_configuration => [:create, :update] }
    permission :scmm_connect_branches, { :scmm_issue_connected_branches => [:create, :destroy, :new] }
  end

  Rails.configuration.to_prepare do
    ScmmPlugin::ProjectSettingsTabsPatch.apply
    ScmmPlugin::ProjectPatch.apply
    ScmmPlugin::MenuHelperPatch.apply
    ScmmPlugin::IssuePatch.apply
  end

end

Redmine::MenuManager.map :issue_sidebar_more_menu do |menu|
  menu.push :new_scmm_issue_connected_branch_patch,
            :link_to_issue_connect_branch,
            caption: :scmm_create_connection,
            html: {
              class: 'button icon icon-relation',
              title: :scmm_create_connection
            },
            if: -> issue { User.current.allowed_to?(:scmm_connect_branches, issue.project) }
end
