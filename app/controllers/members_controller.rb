class MembersController < ApplicationController
  load_resource

  def create
    @member = Member.find_or_create_by(name: params[:member][:name])
    respond_with @member, location: -> { root_path },
                          action: -> { redirect_to :root }
  end

  def show
  end

  def disable
    @member.disable
    respond_with @member, location: -> { root_path }
  end

  def enable
    @member.enable
    respond_with @member, location: -> { root_path }
  end

  def destroy
    @member.destroy
    respond_with @member, location: -> { root_path }
  end

protected

  def resource_params
    params.fetch(:member, {}).permit(:name)
  end
end
