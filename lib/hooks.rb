class ScmmViewHookListener < Redmine::Hook::ViewListener
  render_on :view_issues_show_description_bottom, partial: "connected_branch/connected_branches_list"
end

class ScmmControllerHookListener < Redmine::Hook::Listener

  def helper_issues_show_detail_after_setting(context)
    if context.is_a?(Hash)
      detail = context[:detail]
      case detail.property
      when 'scmm_branch_relation'
        detail.prop_key = l(:label_scmm_connected_branch)
        detail.property = 'relation'
      end
    end
  end

end