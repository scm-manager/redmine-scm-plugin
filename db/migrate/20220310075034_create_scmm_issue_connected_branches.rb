class CreateScmmIssueConnectedBranches < ActiveRecord::Migration[5.2]
  def change
    create_table :scmm_issue_connected_branches do |t|
      t.integer :issue_id
      t.string :branch_name
    end
    add_foreign_key :scmm_issue_connected_branches, :issues, on_delete: :cascade
  end
end
