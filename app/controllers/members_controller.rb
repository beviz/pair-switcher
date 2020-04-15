class MembersController < ApplicationController
  load_and_authorize_resource :team, find_by: :token
  load_and_authorize_resource through: :team

  def create
    @member = @team.members.find_or_create_by(name: params[:member][:name])
    respond_with @member, location: @team
  end

  def show
  end

  def disable
    @member.disable
    respond_with @member, location: @team
  end

  def enable
    @member.enable
    respond_with @member, location: @team
  end

  def destroy
    @member.destroy
    respond_with @member, location: @team
  end

protected

  def resource_params
    params.fetch(:member, {}).permit(:name)
  end
end
