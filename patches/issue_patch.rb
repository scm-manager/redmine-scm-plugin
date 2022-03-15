module ScmmPlugin
  module IssuePatch

    def self.apply
      Issue.send :include, ScmmPlugin::IssuePatch
    end

    def self.included(base)
      base.class_eval do
        has_many :scmm_issue_connected_branches, :dependent => :destroy
      end
    end

  end

  module Hooks
    include Redmine::Hook

    class HelperIssuesHook < Redmine::Hook::Listener

      def helper_issues_show_detail_after_setting(context)
        if context.is_a?(Hash)
          detail = context[:detail]
          case detail.property
          when 'scmm_branch_relation'
            detail.prop_key = l(:label_scmm_connected_branch)
            detail.property = 'attachment'
          end
        end
      end

    end

  end

end
