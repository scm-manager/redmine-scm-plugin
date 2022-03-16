require File.expand_path('../../test_helper', __FILE__)

class ScmmIssueConnectedBranchesControllerTest < ActionController::TestCase

  fixtures :projects,
           :issues,
           :users,
           :roles,
           :members,
           :member_roles

  def setup
    User.current = nil
  end

  def test_new
    @request.session[:user_id] = 2
    Role.find(1).add_permission! :scmm_connect_branches
    Project.find(1).enabled_module_names = [:scm_manager]

    get :new, params: { :issue_id => 1, :project_id => 1 }

    assert_response :success
    assert_template 'new'
  end
end
