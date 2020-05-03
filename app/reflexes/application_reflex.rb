# frozen_string_literal: true

class ApplicationReflex < StimulusReflex::Reflex
  # Put application wide Reflex behavior in this file.
  #
  # Example:
  #
  #   # If your ActionCable connection is: `identified_by :current_user`
  #   delegate :current_user, to: :connection
  #
  # Learn more at: https://docs.stimulusreflex.com

  # def params
  #   @params ||= Rack::Utils.parse_nested_query(element.dataset[:params])
  # end

  def to_params(query)
    Rack::Utils.parse_nested_query(query).with_indifferent_access
  end
end
