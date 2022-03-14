class CreateScmmIssueConnectedBranches < ActiveRecord::Migration[5.2]
  def change
    create_table :scmm_issue_connected_branches do |t|
      t.references :issue, type: :integer, foreign_key: { on_delete: :cascade }
      t.string :branch_name
    end
  end
end
