# frozen_string_literal: true

class MemberReflex < ApplicationReflex
  # Add Reflex methods in this file.
  #
  # All Reflex instances expose the following properties:
  #
  #   - connection - the ActionCable connection
  #   - channel - the ActionCable channel
  #   - request - an ActionDispatch::Request proxy for the socket connection
  #   - session - the ActionDispatch::Session store for the current visitor
  #   - url - the URL of the page that triggered the reflex
  #   - element - a Hash like object that represents the HTML element that triggered the reflex
  #
  # Example:
  #
  #   def example(argument=true)
  #     # Your logic here...
  #     # Any declared instance variables will be made available to the Rails controller and view.
  #   end
  #
  # Learn more at: https://docs.stimulusreflex.com

  def create
    @team = Team.find(element.dataset['team-id'])
    binding.pry
    @team.members.find_or_create_by(name: params[:member][:name])
  end

  def enable
    @team = Team.find(element.dataset['team-id'])
    member = @team.members.find(element.dataset[:id])
    member.enable
  end

  def disable
    @team = Team.find(element.dataset['team-id'])
    member = @team.members.find(element.dataset[:id])
    member.disable
  end
end