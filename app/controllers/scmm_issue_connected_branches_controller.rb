class ScmmIssueConnectedBranchesController < ApplicationController

  before_action :set_issue, :set_project_from_issue, :authorize

  def new
    @branch_connection = ScmmIssueConnectedBranch.new(
      :branch_name => create_branch_name(@issue),
      :issue => @issue
    )
  end

  def create
    @branch_connection = ScmmIssueConnectedBranch.new(branch_connection_params)
    if @branch_connection.save
      write_journal(@branch_connection.branch_name, nil)
      respond_to do |format|
        format.html { redirect_to issue_path(@issue), notice: l("scmm_connection_created") }
        format.json { head :created }
      end
    else
      render :new
    end
  end

  def destroy
    @branch_connection = ScmmIssueConnectedBranch.find(params[:id])
    if @issue != nil && @branch_connection != nil
      write_journal(nil, @branch_connection.branch_name)
    end
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

  def set_project_from_issue
    @project = @issue.project
  end

  def create_branch_name(issue)
    "#{create_prefix(issue)}/#{issue.id}_#{normalize_subject(issue.subject)}"
  end

  def normalize_subject(subject)
    subject
      .downcase
      .gsub(/[^a-z0-9_ ]/, '')
      .gsub(/\s+/, '_')[0..24]
  end

  def create_prefix(issue)
    configuration = issue.project.scmm_project_configuration
    if configuration&.bug_tracker == issue.tracker.name
      return "bugfix"
    end
    "feature"
  end

  def write_journal(value, old_value)
    journal = @issue.init_journal(User.current)
    journal.details << JournalDetail.new(
      :property => 'scmm_branch_relation',
      :prop_key => 'scmm_connected_branch',
      :value => value,
      :old_value => old_value
    )
    journal.save
  end
end
