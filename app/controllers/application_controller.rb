require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  def current_ability
    @current_ability ||= Ability.new(nil)
  end
end
