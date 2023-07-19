module ScmmPlugin
  module EasyProjectSettingsTabsPatch

    def self.included(base)
      base.include(InstanceMethods)

      base.class_eval do
        alias_method_chain :project_settings_tabs, :scmm_plugin
      end
    end

    module InstanceMethods

      def project_settings_tabs_with_scmm_plugin
        tabs = project_settings_tabs_without_scmm_plugin

        if User.current.allowed_to?(:scmm_configure_project, @project)
          tabs << {
            name: 'scmm_project_configuration',
            partial: 'projects/settings/scmm',
            label: :scmm
          }
        end

        tabs
      end

    end

  end
end
RedmineExtensions::PatchManager.register_helper_patch 'ProjectsHelper', 'ScmmPlugin::EasyProjectSettingsTabsPatch'
