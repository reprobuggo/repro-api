class BugsController < ApplicationController
  before_action :set_bug, only: [:show, :update, :destroy]

  # GET /bugs
  def index
    @bugs = Bug.all
    json_response(@bugs)
  end

  # POST /bugs
  def create
    @bug = Bug.create!(bug_params)
    json_response(@bug, :created)
  end

  # GET /bugs/:id
  def show
    json_response(@bug)
  end

  # PUT /bugs/:id
  def update
    @bug.update(bug_params)
    head :no_content
  end

  # DELETE /bugs/:id
  def destroy
    @bug.destroy
    head :no_content
  end

  private

  def bug_params
    # whitelist params
    params.permit(:title, :created_by)
  end

  def set_bug
    @bug = Bug.find(params[:id])
  end
end
