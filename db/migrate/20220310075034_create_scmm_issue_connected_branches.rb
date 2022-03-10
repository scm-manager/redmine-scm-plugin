class CreateScmmIssueConnectedBranches < ActiveRecord::Migration[5.2]
  def change
    create_table :scmm_issue_connected_branches do |t|
      t.string :issue_id
      t.string :branch_name
    end
  end
end
