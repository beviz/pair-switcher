# frozen_string_literal: true

class TeamReflex < ApplicationReflex
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

  def rollback
    team = Team.find(element.dataset[:id])
    team.pair_histories.rollback!
  end

  def pair
    team = Team.find(element.dataset[:id])
    begin
      Assigner.assign_and_save(team.members.available)
      @message = "Pair successfully"
    rescue
      @message = "Pair failed, probably unable to avoid duplicate pairs"
    end
  end
end
