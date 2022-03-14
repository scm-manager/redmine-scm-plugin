class CreateScmmProjectConfigurations < ActiveRecord::Migration[5.2]
  def change
    create_table(:scmm_project_configurations, primary_key: [:project_id]) do |t|
      t.references :project, type: :integer, foreign_key: { on_delete: :cascade }
      t.string :scm_url
      t.string :bug_tracker, default: "Bug"
    end
  end
end
