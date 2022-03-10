class ScmmHookListener < Redmine::Hook::ViewListener
  render_on :view_issues_show_description_bottom, partial: "connected_branch/connected_branches_list"
end