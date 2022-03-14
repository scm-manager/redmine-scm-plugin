class CreateScmmProjectConfigurations < ActiveRecord::Migration[5.2]
  def change
    create_table(:scmm_project_configurations, primary_key: [:project_id]) do |t|
      t.string :project_id
      t.string :scm_url
      t.string :bug_tracker, default: "Bug"
    end
    add_foreign_key :scmm_project_configurations, :projects, on_delete: :cascade
  end
end
