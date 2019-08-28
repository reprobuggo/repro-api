class StepsController < ApplicationController
  before_action :set_bug
  before_action :set_bug_step, only: [:show, :update, :destroy]

  # GET /bugs/:bug_id/steps
  def index
    json_response(@bug.steps)
  end

  # GET /bugs/:bug_id/steps/:id
  def show
    json_response(@step)
  end

  # POST /bugs/:bug_id/steps
  def create
    @bug.steps.create!(step_params)
    json_response(@bug, :created)
  end

  # PUT /bugs/:bug_id/steps/:id
  def update
    @step.update(step_params)
    head :no_content
  end

  # DELETE /bugs/:bug_id/steps/:id
  def destroy
    @step.destroy
    head :no_content
  end

  private

  def step_params
    params.permit(:name, :done)
  end

  def set_bug
    @bug = Bug.find(params[:bug_id])
  end

  def set_bug_step
    @step = @bug.steps.find_by!(id: params[:id]) if @bug
  end
end
