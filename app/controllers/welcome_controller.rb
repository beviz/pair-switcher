require 'assigner'

class WelcomeController < ApplicationController
  def index
  end

  def pair
    begin
      Assigner.assign_and_save(Member.available)
      flash[:notice] = "Pair successfully"
    rescue
      flash[:alert] = "Pair failed, probably unable to avoid duplicate pairs"
    end
    redirect_to :root
  end

  def rollback
    if PairHistory.rollback!
      flash[:notice] = "Rollback successfully"
    else
      flash[:alert] = "No history for rollback"
    end

    redirect_to :root
  end
end
