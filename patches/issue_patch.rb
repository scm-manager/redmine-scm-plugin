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
end