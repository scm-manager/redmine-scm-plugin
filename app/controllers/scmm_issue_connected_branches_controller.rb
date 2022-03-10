class ScmmIssueConnectedBranchesController < ApplicationController

  def new

  end

  def create
    @connected_branch = ScmmIssueConnectedBranch.create(
      connected_branch_params
    )
  end

  def destroy
    ScmmIssueConnectedBranch.destroy(params[:id])
  end

  private

  def connected_branch_params
    params.require(:scmm_issue_connected_branch).permit(:issue_id, :branch_name)
  end
end
