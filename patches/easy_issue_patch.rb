module ScmmPlugin
  module EasyIssuePatch

    def self.included(base)
      base.class_eval do
        has_many :scmm_issue_connected_branches, :dependent => :destroy
      end
    end

  end
end

RedmineExtensions::PatchManager.register_model_patch 'Issue', 'ScmmPlugin::EasyIssuePatch'
