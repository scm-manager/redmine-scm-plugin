class ScmmIssueConnectedBranch < ActiveRecord::Base
  belongs_to :issue
  validates :branch_name, length: { in: 2..255 }
end
