class MembersController < ApplicationController
  load_resource

  def create
    @member = Member.find_or_create_by(name: params[:member][:name])
    respond_with @member, location: -> { root_path },
                          action: -> { redirect_to :root }
  end

  def show
  end

protected

  def resource_params
    params.fetch(:member, {}).permit(:name)
  end
end
