class CreateProjectConfigurations < ActiveRecord::Migration[5.2]
  def change
    create_table(:project_configurations, primary_key: [:project_id]) do |t|
      t.string :project_id
      t.string :scm_url
      t.string :bug_tracker, default: "Bug"
    end
  end
end
