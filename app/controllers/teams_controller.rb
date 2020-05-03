class TeamsController < ApplicationController
  load_and_authorize_resource find_by: :token

  def index
  end

  def show
  end

  def create
    @team.save
    respond_with @team
  end

  def pair
    begin
      Assigner.assign_and_save(@team.members.available)
      flash[:notice] = "Pair successfully"
    rescue
      flash[:alert] = "Pair failed, probably unable to avoid duplicate pairs"
    end
    redirect_to @team
  end

  def rollback
    if @team.pair_histories.rollback!
      flash[:notice] = "Rollback successfully"
    else
      flash[:alert] = "No history for rollback"
    end

    redirect_to @team
  end

  def team_params
    params.fetch(:team, {}).permit(:name)
  end
end
