require File.expand_path('../../test_helper', __FILE__)

class ScmmIssueConnectedBranchesControllerTest < Redmine::ControllerTest

  fixtures :projects,
           :issues,
           :users,
           :roles,
           :members,
           :member_roles

  def setup
    @request.session[:user_id] = 2
    Role.find(1).add_permission! :scmm_connect_branches
    Project.find(1).enabled_module_names = [:scm_manager]
  end

  def test_new_with_normal_tracker_with_shortened_subject
    get :new, params: { :issue_id => 2 }

    assert_response :success
    assert_select '#scmm_issue_connected_branch_branch_name' do
      assert_select "[value=?]", "feature/2_add_ingredients_categorie"
    end
  end

  def test_new_with_bug_tracker
    get :new, params: { :issue_id => 1 }

    assert_response :success
    assert_select '#scmm_issue_connected_branch_branch_name' do
      assert_select "[value=?]", "bugfix/1_cannot_print_recipes"
    end
  end

  def test_create
    post(
      :create,
      :params => {
        :issue_id => 1,
        :scmm_issue_connected_branch => {
          :issue_id => 1,
          :branch_name => 'feature/good_one'
        }
      }
    )

    assert_redirected_to "http://test.host/issues/1"
    relation = ScmmIssueConnectedBranch.order('id DESC').first
    assert_equal 1, relation.issue.id
    assert_equal 'feature/good_one', relation.branch_name
  end

  def test_create_with_invalid_branch
    post(
      :create,
      :params => {
        :issue_id => 1,
        :scmm_issue_connected_branch => {
          :branch_name => ''
        }
      }
    )

    assert_response :success
    relation = ScmmIssueConnectedBranch.first
    assert_nil relation
  end
end
