module ScmmPlugin
  module ProjectSettingsTabsPatch
    def self.apply
      unless defined?(RedmineExtensions)
        ProjectsController.send :helper, ScmmPlugin::ProjectSettingsTabsPatch
      end
    end

    def project_settings_tabs
      tabs = super
      if User.current.allowed_to?(:scmm_configure_project, @project)
        tabs.push({
                    name: 'scmm_project_configuration',
                    partial: 'projects/settings/scmm',
                    label: :scmm
                  })
      end
      tabs
    end

  end

end
