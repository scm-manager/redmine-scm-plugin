module ScmmPlugin
  module EasyProjectPatch

    def self.included(base)
      base.class_eval do
        has_one :scmm_project_configuration, :dependent => :destroy
      end
    end

  end
end

RedmineExtensions::PatchManager.register_model_patch 'Project', 'ScmmPlugin::EasyProjectPatch'
