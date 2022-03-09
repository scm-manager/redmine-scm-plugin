module ScmmPlugin
  module ProjectSettingsTabsPatch
    def self.apply
      ProjectsController.send :helper, ScmmPlugin::ProjectSettingsTabsPatch
    end

    def project_settings_tabs
      tabs = super
      if User.current.allowed_to?(:project_configuration, @project)
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
