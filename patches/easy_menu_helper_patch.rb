module ScmmPlugin

  module EasyMenuHelperPatch

    def self.included(base)
      base.class_eval do
        def link_to_issue_connect_branch
          if User.current.allowed_to?(:scmm_connect_branches, @issue.project)
            new_issue_scmm_issue_connected_branch_path(@issue)
          end
        end
      end
    end

  end
end

RedmineExtensions::PatchManager.register_helper_patch 'Redmine::MenuManager::MenuHelper', 'ScmmPlugin::EasyMenuHelperPatch'
