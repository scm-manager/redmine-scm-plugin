# Load the Redmine helper
require File.expand_path(File.dirname(__FILE__) + '/../../../test/test_helper')
ActiveRecord::FixtureSet.create_fixtures(File.dirname(__FILE__) + '/fixtures/', [:scmm_project_configurations])
ActiveRecord::FixtureSet.create_fixtures(File.dirname(__FILE__) + '/fixtures/', [:scmm_issue_connected_branches])
