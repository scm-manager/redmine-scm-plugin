class ScmmIssueConnectedBranch < ActiveRecord::Base
  belongs_to :issue
  validates :branch_name,
            length: { in: 1..255 },
            format: { with: /\A[\w\-,;\]{}@&+=$#`|<>]([\w\-,;\]{}@&+=$#`|<>\/.]*[\w\-,;\]{}@&+=$#`|<>])?\z/ }
end
