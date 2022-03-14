module ScmmPlugin

  module MenuHelperPatch

    def self.included(base)
      base.class_eval do
        def link_to_issue_connect_branch
          # { :controller => 'scmm_issue_connected_branches_controller', :action => 'new', :issue_id => @issue.id }
          new_issue_scmm_issue_connected_branch_path(@issue)
        end
      end
    end

    def self.apply
      Redmine::MenuManager::MenuHelper.send :include, ScmmPlugin::MenuHelperPatch
    end

  end
end
