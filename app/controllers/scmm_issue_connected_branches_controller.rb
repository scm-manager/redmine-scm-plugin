class ScmmIssueConnectedBranchesController < ApplicationController

  before_action :set_issue, only: [:new]

  def new
    @branch_connection = ScmmIssueConnectedBranch.new(branch_name: "abc")
  end

  def create
    @branch_connection = ScmmIssueConnectedBranch.create(
      branch_connection_params
    )
    respond_to do |format|
      format.html { redirect_to issue_path(@branch_connection.issue), notice: l("scmm_connection_created") }
      format.json { head :created }
    end
  end

  def destroy
    ScmmIssueConnectedBranch.destroy(params[:id])
    respond_to do |format|
      format.html { redirect_to :back, notice: l("scmm_connection_deleted") }
      format.json { head :no_content }
    end
  end

  private

  def branch_connection_params
    params.require(:scmm_issue_connected_branch).permit(:issue_id, :branch_name)
  end

  def set_issue
    @issue = Issue.find(params[:issue_id])
  end
end
