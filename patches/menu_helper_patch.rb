module ScmmPlugin

  module MenuHelperPatch

    def self.included(base)
      base.class_eval do
        def link_to_issue_connect_branch
          if User.current.allowed_to?(:scmm_connect_branches, @issue.project)
            new_issue_scmm_issue_connected_branch_path(@issue)
          end
        end
      end
    end

    def self.apply
      Redmine::MenuManager::MenuHelper.send :include, ScmmPlugin::MenuHelperPatch
    end

  end
end
